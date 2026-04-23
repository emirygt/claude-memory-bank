#!/bin/bash
# init-memory.sh — Herhangi bir projeye Claude Memory Bank kur
# Kullanım: bash init-memory.sh [hedef-dizin]

TARGET="${1:-.}"
MEMORY="$TARGET/.memory"

echo "🧠 Claude Memory Bank kurulumu"
echo ""

read -p "Proje adı: " PROJECT_NAME
read -p "Kısa açıklama (1 cümle): " PROJECT_DESC
read -p "Backend stack (örn. FastAPI + PostgreSQL): " STACK_BACKEND
read -p "Frontend (boş bırakabilirsin): " STACK_FRONTEND
read -p "Şu anki görev: " ACTIVE_TASK

DATE=$(date +%Y-%m-%d)
mkdir -p "$MEMORY"

# Mevcut dosyayı kontrol et, varsa sor
write_file() {
  local file="$1"
  local content="$2"
  if [ -f "$file" ]; then
    read -p "⚠️  '$(basename $file)' zaten var. Üzerine yazılsın mı? (e/H): " confirm
    if [[ ! "$confirm" =~ ^[eE]$ ]]; then
      echo "⏭️  $(basename $file) atlandı"
      return
    fi
  fi
  printf '%s\n' "$content" > "$file"
  echo "✅ $(basename $file) oluşturuldu"
}

write_file "$TARGET/CLAUDE.md" "# CLAUDE.md

## BAŞLAMADAN ÖNCE — MUTLAKA OKU
1. \`.memory/core.md\` → proje özeti + stack (HER ZAMAN)
2. \`.memory/active.md\` → aktif görev + bağlam (HER ZAMAN)
3. \`.memory/arch.md\` → sadece yeni özellik/refactor yazarken
4. \`.memory/patterns.md\` → sadece kod yazarken
5. \`.memory/done.md\` → OKUMA, gerekmedikçe

## ÇALIŞMA KURALLARI
- Sadece söylenen dosyaları aç, keşif yapma
- Değişen dosyaları tam gösterme, sadece diff yaz
- Her yanıt sonunda .memory/active.md güncellenmesi gerekiyorsa söyle
- Açıklama yazma, direkt koda gir
- Test dosyalarını ve migration geçmişini okuma

## YANIT FORMATI
[Ne yapıldı - 1 satır]
[Kod değişikliği]
[Varsa sonraki adım - 1 satır]"

write_file "$MEMORY/core.md" "# CORE — Proje Özeti

## Proje
$PROJECT_NAME — $PROJECT_DESC

## Stack
- **Backend:** $STACK_BACKEND
- **Frontend:** ${STACK_FRONTEND:-"—"}

## Dizin Yapısı
[Buraya kendi yapını yaz]

## Kritik Dosyalar
| Dosya | Amaç |
|-------|------|
| [dosya] | [açıklama] |

---
*Son güncelleme: $DATE*"

write_file "$MEMORY/active.md" "# ACTIVE — Şu Anki Görev

## Aktif Görev
$ACTIVE_TASK

## Bağlam
- Neden yapılıyor: —
- Etkilenen dosyalar: —

## Son Karar
> —

## Sonraki Adım
- [ ] —

---
## Bekleyen Görevler (sıralı)
1. —

---
*Her Claude oturumu sonunda güncelle*"

write_file "$MEMORY/arch.md" "# ARCH — Mimari Kararlar

## Temel Prensipler
- [Prensip 1]
- [Prensip 2]

## Veri Akışı
[Buraya akışı yaz]

## Kritik Kararlar
| Karar | Neden | Tarih |
|-------|-------|-------|
| — | — | $DATE |

## Anti-Patterns (YAPMA)
- [ ] —"

write_file "$MEMORY/patterns.md" "# PATTERNS — Kod Kalıpları

## Temel Şablon
[En çok kullandığın kod kalıbını buraya yaz]

## Hata Yönetimi
[Hata fırlatma / yakalama kalıbı]

## Naming Kuralları
- [Kural 1]
- [Kural 2]

---
*Claude'a 'src/ klasörünü analiz et, patterns.md yi doldur' de*"

write_file "$MEMORY/done.md" "# DONE — Tamamlanan İşler
<!-- Bu dosyayı Claude'a okutma -->

## $DATE
- (başlangıç)

## Teknik Borç
| Borç | Öncelik | Not |
|------|---------|-----|
| — | — | — |"

# .claudeignore
if [ -f "$TARGET/.claudeignore" ]; then
  read -p "⚠️  '.claudeignore' zaten var. Üzerine yazılsın mı? (e/H): " confirm
  [[ "$confirm" =~ ^[eE]$ ]] && _ci=true || echo "⏭️  .claudeignore atlandı"
else
  _ci=true
fi

if [ "$_ci" = true ]; then
cat > "$TARGET/.claudeignore" << 'IGNORE'
.git/
node_modules/
venv/
.venv/
__pycache__/
*.pyc
dist/
build/
*.egg-info/
tests/
test_*.py
*_test.py
htmlcov/
.coverage
alembic/versions/
migrations/
*.pdf
*.png
*.jpg
*.jpeg
*.svg
*.ico
*.woff*
*.ttf
*.dwg
*.dxf
*.zip
*.tar.gz
.env
.env.*
*.key
*.pem
secrets/
*.log
logs/
tmp/
.cache/
.DS_Store
.vscode/settings.json
.idea/
package-lock.json
yarn.lock
poetry.lock
Pipfile.lock
*.md
!CLAUDE.md
!.memory/*.md
IGNORE
  echo "✅ .claudeignore oluşturuldu"
fi

echo ""
echo "✅ Kurulum tamamlandı: $TARGET"
echo ""
echo "──────────────────────────────────────────"
echo "📋 Claude Code'u aç, şu promptu yapıştır:"
echo "──────────────────────────────────────────"
echo ""
echo "Projeyi analiz et ve şu dosyaları doldur:"
echo "1. .memory/core.md → dizin yapısını ve kritik dosyaları yaz"
echo "2. .memory/patterns.md → projenin gerçek kod kalıplarını çıkar"
echo "3. .memory/arch.md → mimari kararları ve veri akışını yaz"
echo "Sadece bu 3 dosyayı yaz, başka bir şey yapma."
echo ""
echo "──────────────────────────────────────────"
