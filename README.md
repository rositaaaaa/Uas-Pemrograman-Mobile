# 🌏 Wisata Indonesia

**Wisata Indonesia** adalah aplikasi mobile berbasis Flutter yang membantu pengguna menjelajahi berbagai destinasi wisata menarik di Indonesia.  
Aplikasi ini menyediakan fitur login, pencarian destinasi, favorit (bookmark), todo perjalanan, dan profil pengguna.

Project ini dibuat sebagai bagian dari tugas **UAS Pemrograman Mobile**.

---

## ✨ Fitur Aplikasi

- 🔐 **Autentikasi Pengguna**
  - Login & Register menggunakan email dan password (Firebase Auth)

- 🏝️ **Destinasi Wisata**
  - Menampilkan daftar destinasi wisata Indonesia
  - Melihat detail destinasi

- 🔍 **Pencarian**
  - Mencari destinasi berdasarkan nama

- ❤️ **Bookmark / Favorit**
  - Menandai destinasi favorit
  - Melihat daftar favorit

- 📝 **Todo Perjalanan**
  - Menambah dan melihat rencana perjalanan

- 👤 **Profil Pengguna**
  - Melihat informasi akun

- 🎨 **Tema Aplikasi**
  - Pengaturan tema menggunakan service

---

## 🚀 Teknologi yang Digunakan

- **Flutter** (Dart)
- **Firebase Authentication**
- **Firebase Core**
- **Provider** (State Management)

---

## 📂 Struktur Project

```txt
lib/
├── main.dart
├── firebase_options.dart
│
├── screens/
│   ├── bookmark_screen.dart
│   ├── destination_detail_screen.dart
│   ├── home_screen.dart
│   ├── login_screen.dart
│   ├── profile_screen.dart
│   ├── search_screen.dart
│   └── todo_screen.dart
│
├── services/
│   ├── auth_service.dart
│   └── theme_service.dart
⚙️ Cara Menjalankan Aplikasi
Clone repository:

bash
Copy code
git clone https://github.com/rositaaaaa/Uas-Pemrograman-Mobile.git
Masuk ke folder project:

bash
Copy code
cd Uas-Pemrograman-Mobile
Install dependency:

bash
Copy code
flutter pub get
Jalankan aplikasi:

bash
Copy code
flutter run
🔑 Konfigurasi Firebase
Pastikan file berikut sudah tersedia:

lib/firebase_options.dart

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Firebase digunakan untuk:

Autentikasi pengguna (login & register)

🧪 Akun Uji Coba (Opsional)
Email: demo@gmail.com
Password: 123456

📱 Screenshot
Tambahkan screenshot aplikasi di sini untuk tampilan UI.

👩‍💻 Developer
Nama: Rosita

Aplikasi: Wisata Indonesia

Mata Kuliah: Pemrograman Mobile

Tahun: 2025

📄 Lisensi
Project ini dibuat untuk keperluan pembelajaran dan tugas akademik.
Bebas digunakan dan dikembangkan lebih lanjut.

yaml
Copy code

---

## ✅ Setelah itu, simpan & push:

```bash
git add README.md
git commit -m "Add README for Wisata Indonesia app"
git push
link 
https://github.com/rositaaaaa/Uas-Pemrograman-Mobile/releases/download/v1.0.0/app-release.apk
