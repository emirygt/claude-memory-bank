# ARCH — Mimari Kararlar

## Temel Prensipler
- [Prensip 1 — örn. "Service layer business logic içerir, route'lar sadece HTTP"]
- [Prensip 2]
- [Prensip 3]

## Veri Akışı
```
Request → Router → Service → Repository → DB
                ↓
           External API
```

## Kritik Kararlar
| Karar | Neden | Tarih |
|-------|-------|-------|
| [örn. HNSW index kullan] | [sebep] | [tarih] |
| [örn. Multi-tenant row-level] | [sebep] | [tarih] |

## Anti-Patterns (YAPMA)
- [ ] Route içinde DB sorgusu
- [ ] [proje spesifik yasak]

## Servisler Arası İlişki
```
[ServiceA] → depends on → [ServiceB]
[ServiceC] → independent
```

---
*Büyük karar alındığında güncelle*
