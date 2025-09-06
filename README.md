# 📖 EPrints + MariaDB + phpMyAdmin (Docker)

## 📌 Layanan yang Disediakan
- **EPrints App** → aplikasi utama EPrints (Ubuntu + Apache2 + Perl + dependensi).  
- **MariaDB 10.6** → database server untuk EPrints.  
- **phpMyAdmin** → antarmuka web untuk mengelola database.  

## ⚙️ Cara Install & Jalankan

### 1. Clone Repo & Build Image
```bash
git clone <repo-url>
cd <repo-folder>
docker-compose build
```

### 2. Jalankan Semua Service
```bash
docker-compose up -d
```

### 3. Akses Layanan
- **EPrints** → http://localhost:1988  
- **phpMyAdmin** → http://localhost:1989  
  - Host: `eprints-db`
  - User: `root`
  - Pass: `rootpass`

## 🔧 Konfigurasi EPrints

Masuk ke container:
```bash
docker exec -it eprints-app bash
su - eprints
```

Jalankan wizard:
```bash
./bin/epadmin create pub repository
```

Gunakan setting DB:
- Host: `eprints-db`
- User root: `root`
- Pass: `rootpass`
- DB Name: `repository`
- DB User: `eprints`
- DB Pass: `eprintspass`

Lalu buat tabel:
```bash
./bin/epadmin create_tables repository
```

## 📂 Data Persisten
- `db_data/` → data MariaDB  
- `eprints_data/` → konfigurasi & arsip EPrints  

## 🛑 Stop & Reset
```bash
docker-compose down
docker-compose down -v   # hapus data juga
```
