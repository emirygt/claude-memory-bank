# CORE — Proje Özeti

## Proje
[PROJE_ADI] — [tek cümle açıklama]

## Stack
- **Backend:** [örn. FastAPI + PostgreSQL]
- **AI/ML:** [örn. CLIP embeddings + pgvector HNSW]
- **Frontend:** [örn. Next.js 14]
- **Infra:** [örn. Docker + Redis]

## Dizin Yapısı
```
src/
  api/          → FastAPI routes
  services/     → iş mantığı
  models/       → DB modelleri
  core/         → config, utils
tests/
```

## Kritik Dosyalar
| Dosya | Amaç |
|-------|------|
| `src/core/config.py` | tüm env değişkenleri |
| `src/models/base.py` | temel model sınıfı |

## Ortam
- Python 3.11 / Node 20
- `.env` → `src/core/config.py` üzerinden okunur

---
*Son güncelleme: [TARİH]*
