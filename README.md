# 🎬 TMDb Movie App (SwiftUI)

A simple iOS app built using **SwiftUI** and **The Movie Database (TMDb) API**.  
The app lists popular movies, allows search, shows detailed information with trailers, and supports marking favorites.

---
#
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

static let apiKey = "YOUR_API_KEY_HERE"

with your actual TMDb key.

### 3️⃣ Open and Run
Open the project in Xcode 15+

Select a simulator (iPhone 15 recommended)

Press Cmd + R to build and run.

No additional dependencies are required.

🧠 Assumptions
The app is built for iOS 16+.

Internet connection is required to fetch data and trailers.

TMDb’s image and video links are valid for poster/trailer display.

YouTube videos are assumed to allow embedding (some may not, showing error 153).

⚠️ Known Limitations
Some videos are restricted and may not play (Error 153 from YouTube).

Movie runtime requires an additional API call for each row (may slightly affect list performance).

No offline caching — app requires active internet access.

No pagination for large lists (fetches one page of popular results).

