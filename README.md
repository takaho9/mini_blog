# ソニックガーデンキャンプのプレ課題

## 環境構築
1. ルートに `.env` 準備
```env
POSTGRES_USER=any_name
POSTGRES_PASSWORD=any_password
POSTGRES_DB=any_db_name
```
2. ビルド・アップ
```sh
docker-compose -f docker-compose-dev.yml up
```

## デモ
https://mini-blog-1y38.onrender.com/

デモ用アカウント
| Email               | Password  |
|---------------------|-----------|
| bob@example.com     | password  |
| alice@example.com   | password  |
