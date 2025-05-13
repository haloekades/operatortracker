## 📱 Project Overview

This is a **Operational Tracker App** designed for industrial or operational use, with a focus on device-based login, activity selection, and real-time communication through a WebSocket-powered chat feature. The project is structured using **Clean Architecture**, **BLoC**, and **Dependency Injection** to ensure testability, maintainability, and scalability.

---

## 🔧 Features

### 1. 🔐 Register Device
- Registers the tablet device with the backend system using a unique device ID.
- If the device is not registered or activated, appropriate states are shown in the installation wizard.

### 2. 👤 Login Page
- Allows the user to log in using a **NIK** (employee identification number).

### 3. 🗺️ Home Page
- Simple dashboard for selecting user activities.
- Renders a **static map view** for the assigned unit (or location).
- Starts listening to equipment messages via WebSocket upon entering this screen.

### 4. 💬 Chat
- Enables real-time chat functionality using **WebSocket** (Centrifugo v0.8.0).
- Fetches message history via REST API.
- Sends and listens to new messages in real time.
- Messages are styled depending on the sender (self vs others).

---

## 🧪 Unit Testing

All core business logic has been covered by unit tests:

### ✅ Tested Use Cases
- `CheckDeviceUseCase`
- `RegisterDeviceUseCase`
- `LoginUseCase`
- `GetChatMessagesUseCase`
- `SendChatMessageUseCase`
- `ListenChatMessagesUseCase`

### ✅ Tested BLoCs
- `InstallationBloc`
- `LoginBloc`
- `ChatBloc`
- `HomeBloc`

Unit testing includes:
- State transitions
- Handling of API success/failure
- Simulated WebSocket message flows

---

## 🛠️ Tech Stack

### 📱 Framework
- **Flutter**: Cross-platform UI toolkit

### 🧠 State Management
- **BLoC (flutter_bloc)**: Event-based predictable state management

### 🧱 Architecture
- **Clean Architecture**:
    - `Domain`: Use Cases and Entities
    - `Data`: API implementations, repositories
    - `Presentation`: UI and BLoC/Event/State management

### 🌐 Real-Time Messaging
- **WebSocket**: Using [Centrifugo v0.8.0](https://centrifugal.dev)
- Integration through a service class wrapping `web_socket_channel` or `centrifuge-dart`

### 🧩 Dependency Injection
- **GetIt**: Service locator for injecting use cases, repositories, and services

### 🧪 Testing
- **bloc_test**: For BLoC state testing
- **mockito**: For mocking dependencies
- **build_runner**: For generating mocks

---

## 📁 Project Structure (Feature-Based)

```
lib/
├── core/
│   └── constants/        # Constant variable
│   └── services/         # Websocket services
│   └── di/               # Dependency Injection Setup
│   └── session/          # To save session
├── features/
│   ├── installation/      # Device registration feature
│   ├── login/             # NIK-based login
│   ├── home/              # Activity selection & dummy static map, subscribe websocket to show popup message
│   ├── chat/              # Chat via WebSocket
└── main.dart
```

## 🚀 Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/haloekades/operatortracker.git
   cd operatortracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

4. Run tests:
   ```bash
   flutter test
   ```
   
---

## 📱 Screen Recording Running App

- [Screen Recording](https://drive.google.com/file/d/1f7fvkfJMby24X5zo2gcRewQyx8dNdXSX/view)


© 2025 Operational Tracker App by Ekades
