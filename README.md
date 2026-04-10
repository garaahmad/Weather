# GlobalWeather 🌍 🌦️

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=for-the-badge&logo=Firebase&logoColor=white)](https://firebase.google.com/)
[![BLoC](https://img.shields.io/badge/BLoC-Cubit-blue?style=for-the-badge)](https://pub.dev/packages/flutter_bloc)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

An advanced, enterprise-grade weather dashboard application built with **Flutter**, engineered with **Clean Architecture** principles and powered by **Firebase**. This project delivers a high-fidelity, interactive, and seamless user experience tailored for modern weather enthusiasts. 🚀

---

## ✨ Key Features

| Feature | Description | Icon |
| :--- | :--- | :---: |
| **Premium Dashboard** | Sleek and modern dark-themed UI for optimal readability. | 💎 |
| **Real-time Weather** | Accurate live data fetched globally via OpenWeatherMap API. | 🌡️ |
| **Interactive Maps** | High-performance maps to track global weather patterns. | 🗺️ |
| **Firebase Auth** | Secure login systems including Social Sign-in integration. | 🔐 |
| **Periodic Notifications**| Background weather updates delivered every 5 hours. | 🔔 |
| **Adaptive Settings** | Fully customizable units (Celsius/Fahrenheit/Kelvin). | ⚙️ |

---

## 🎨 UI Showcase

````carousel
```text
[ Splash Screen ]
Sleek entry animation highlighting the GlobalWeather brand.
```
<!-- slide -->
```text
[ Login Page ]
Secure authentication portal with intuitive design.
```
<!-- slide -->
```text
[ Weather Dashboard ]
Live weather stats, humidity, wind speed, and UV index.
```
````

---

## 🛠️ Tech Stack & Architecture

This application is built for maximum scalability and maintainability:

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Cubit (Flutter BLoC)](https://pub.dev/packages/flutter_bloc)
- **Backend Services**: [Firebase Authentication](https://firebase.google.com/docs/auth), Cloud Messaging.
- **Mapping Engine**: [Flutter Map (Leaflet based)](https://pub.dev/packages/flutter_map)
- **Background Tasks**: [Workmanager](https://pub.dev/packages/workmanager) for periodic updates.
- **Architecture**: **Clean Architecture** (Separation of Data, Domain, and Presentation).
- **Network**: [Dio/Http](https://pub.dev/packages/http) with robust error handling.

---

## 📁 Project Structure

```text
lib/
├── core/                  # Shared utilities, themes, and common widgets
├── features/
│   ├── auth/              # Authentication module (Login, Signup, Social)
│   ├── location/          # Permission handling and location tracking
│   └── weather/           
│       ├── data/          # Models, Data Sources & Repository Implementations
│       ├── domain/        # Entities, Repository Interfaces & Use Cases
│       └── presentation/  # Cubits, Pages, and Interactive Widgets
└── main.dart              # Dependency Injection and App Entry point
```

---

## 🚀 Getting Started

### Prerequisites

*   Flutter SDK (^3.11.0)
*   Firebase Project Setup (GoogleServices-Info.plist / google-services.json)
*   OpenWeatherMap API Key

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/garaahmad/Weather.git
    ```

2.  **Initialize Firebase**:
    Ensure your Firebase configuration is correctly placed in `android/app/` and `ios/Runner/`.

3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

4.  **Run the application**:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution

We welcome contributions! If you would like to enhance GlobalWeather:
1.  Fork the project.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Developed with ❤️ by [Ahmed Gara](https://github.com/garaahmad) 🌦️
