# Claude Memory Bank 🧠

Claude Code için token tasarrufu sağlayan hafıza sistemi.  
Her oturumda Claude **sadece ihtiyacı olan dosyaları** okur.

## Neden?

Claude Code her prompt'ta context'teki her şeyi tekrar işler.  
Bu template ile token kullanımı **%60-80 azalır**.

## Kurulum

```bash
# Projenin köküne kopyala
cp -r claude-memory-bank/. your-project/

# .memory/ dosyalarını doldur
# core.md → proje bilgilerini yaz
# active.md → şu anki görevi yaz
# arch.md, patterns.md → projeye göre özelleştir
```

## Dosya Yapısı

```
CLAUDE.md              ← Claude'un ilk okuduğu, minimalist
.claudeignore          ← Token yiyen dosyaları gizler
.memory/
  core.md              ← Proje özeti (HER ZAMAN okunur, ~50 satır)
  active.md            ← Aktif görev (HER ZAMAN okunur, ~30 satır)
  arch.md              ← Mimari (sadece özellik yazarken)
  patterns.md          ← Kod kalıpları (sadece kod yazarken)
  done.md              ← Geçmiş (HİÇ okunmaz, sadece referans)
scripts/
  memory-update.sh     ← Oturum sonu helper
```

## Kullanım

### Oturum başı
Claude Code'u aç, doğrudan göreve gir:
```
search servisine pagination ekle
```
Claude otomatik `core.md` + `active.md` okur, diğerlerini sadece gerekirse açar.

### Oturum sonu
```bash
./scripts/memory-update.sh
# Çıkan prompt'u Claude'a yapıştır
```

### Yeni özellik = yeni conversation
Her büyük görev için `/clear` veya yeni pencere aç.

## Token Tasarrufu Tablosu

| Yöntem | Kazanım |
|--------|---------|
| `.claudeignore` agresif | ~%40 |
| Tiered memory (sadece core+active) | ~%30 |
| Yeni conversation per feature | ~%20 |
| Diff-only yanıtlar | ~%15 |

## Projeye Özelleştirme

`patterns.md` en çok değeri yaratan dosyadır.  
Projenin gerçek kod kalıplarını buraya yaz →  
Claude her seferinde kodunu keşfetmek yerine pattern'e uyar.

---
MIT License
