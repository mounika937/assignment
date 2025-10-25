# 🎬 TMDb Movie App (SwiftUI)

A simple iOS app built using **SwiftUI** and **The Movie Database (TMDb) API**.  
The app lists popular movies, allows search, shows detailed information with trailers, and supports marking favorites.

---

## 🚀 Features

✅ **Popular Movies List**
- Fetches and displays trending movies with title, poster, rating, and runtime.

✅ **Movie Details Page**
- Shows full plot, genres, cast list, and trailer (via YouTube embed or fallback).

✅ **Search**
- Search movies by title using TMDb search API.

✅ **Favorites**
- Mark/unmark movies as favorites.
- Persists favorites using `UserDefaults`.

✅ **Async/Await Networking**
- Built with modern Swift concurrency for responsive UI.

---

## ⚙️ Setup Instructions

### 1️⃣ Get a TMDb API Key
- Visit [https://www.themoviedb.org](https://www.themoviedb.org)  
- Create an account and generate a **Developer API Key**.
- Copy your key.

### 2️⃣ Add Your Key
Open `TMDbService.swift` and replace:

```swift
static let apiKey = 93540f515966d8a3d07bdfb4ea65948b
