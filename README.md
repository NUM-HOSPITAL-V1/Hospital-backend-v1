# Project Guide

## 1. Сервисийг локал дээрээ суулгаж, ажиллуулах заавар

1. Доорх кодыг ажиллуулж prerequisites-ээ татна.

```sh
npm install
```

2. `env.example.txt` файлыг `.env` болго
3. MongoDB Compass ашиглан баазтай холбогдох:

   Compass дээр өөрийн `.env` доторх `MONGO_URI` connection string-ийг ашиглан баазтай холбогдоно.

4. Доорх коммандаар ажиллуулах

```sh
npm install 
npm run dev
```

## 2. Folder Structure

```bash
project-root/
├── node_modules/ # npm install хийсний дараа суух хамааралтай сангууд
├── controller/   # Логик үйлдүүд
├── models/       # Өгөгдлийн сангийн схемүүд
├── routes/       # API endpoint-ууд
├── .gitignore
├── package.json  # Сервисийн dependencies, скриптүүд
├── README.md
└── .env          # Environmental variables
```

## 3. API Endpoints

## Сервисийн ерөнхий

| Method | URL              | Description                             |
| ------ | ---------------- | --------------------------------------- |
| `GET`  | `/api/v1/health` | Just to check if the service is running |

### Auth

| Method | URL                            | Description              |
| ------ | ------------------------------ | ------------------------ |
| `POST` | `/api/v1/signup/medical-staff` | Create new medical staff |

## 4. Зарим тайлбарууд

1. Folder structure болон `auth.controller.js` гэх мэт stylistic choice-ыг сольж болно.
2. helpers, validators нэмье гэж бодож байгаа (дараагаар). Мөн auth middleware бичнэ.

## 5 Test Users

Локал/тест орчинд шаардлагатай хэрэглэгчдээ seed script эсвэл админ endpoint-оор үүсгэж ашиглана.
Бодит email/password эсвэл access credential-ийг README болон git commit-д хадгалахгүй.
