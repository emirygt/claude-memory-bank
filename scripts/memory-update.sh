#!/bin/bash
# memory-update.sh — Oturum sonunda memory'yi güncelle
# Kullanım: ./scripts/memory-update.sh

echo "📋 Mevcut active.md:"
echo "---"
cat .memory/active.md
echo "---"
echo ""
echo "✏️  Claude'a şunu söyle:"
echo ""
echo "---PROMPT KOPYALA---"
cat << 'EOF'
.memory/active.md dosyasını güncelle:
- Tamamlanan görevleri işaretle
- Sonraki adımı güncelle  
- Son karar varsa ekle
Dosyanın tamamını yaz, açıklama yapma.
EOF
echo "---PROMPT BİTTİ---"
