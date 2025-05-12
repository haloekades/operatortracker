# Flutter Operator Tracker

A Flutter application built with clean architecture that supports device registration, user login, activity selection, static map rendering, and real-time chat using WebSockets.

---

## ✨ Features

### 1. 📱 Register Device
- On first launch, the app guides the user through device registration.
- Registers a unique device ID with the backend.

### 2. 🔐 Login Page
- Allows users to log in using their NIK (employee ID or similar).
- Validates credentials and stores session securely.

### 3. 🗺️ Home
- After login, users land on the home screen.
- Displays a list of available activities.
- Shows a static map as a placeholder.

### 4. 💬 Chat
- Real-time chat feature.
- Messages are received via **WebSocket** using [Centrifuge](https://github.com/centrifugal/centrifuge-dart) v0.8.0.
- Messages are sent using a REST API.
- Displays chat history and supports sending/receiving messages instantly.

---

## 🛠 Tech Stack

| Technology       | Description                          |
|------------------|--------------------------------------|
| **Flutter**      | Mobile SDK for Android & iOS         |
| **BLoC**         | State management via `flutter_bloc`  |
| **Clean Architecture** | Domain-driven design with clear separation of concerns |
| **WebSocket**    | Real-time updates via Centrifuge     |
| **Dependency Injection** | Using `get_it` for DI container |

---