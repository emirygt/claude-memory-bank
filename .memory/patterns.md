# PATTERNS — Kod Kalıpları

## Servis Şablonu
```python
class XxxService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def do_something(self, tenant_id: UUID, ...) -> XxxSchema:
        # iş mantığı buraya
        ...
```

## Route Şablonu
```python
@router.post("/endpoint", response_model=XxxResponse)
async def create_xxx(
    payload: XxxCreate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    return await XxxService(db).create(current_user.tenant_id, payload)
```

## Hata Yönetimi
```python
raise HTTPException(status_code=404, detail="xxx_not_found")
# detail her zaman snake_case string
```

## DB Sorgusu
```python
result = await db.execute(
    select(Model).where(Model.tenant_id == tenant_id)
)
return result.scalars().all()
```

## Naming
- Servisler: `XxxService` → `src/services/xxx.py`
- Şemalar: `XxxCreate`, `XxxUpdate`, `XxxResponse`
- Route prefix: `/api/v1/xxx`

## Import Sırası
1. stdlib
2. third-party (fastapi, sqlalchemy...)
3. local (`from src.xxx import ...`)

---
*Yeni kalıp eklenince güncelle*
