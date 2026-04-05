# GlobalWeather 🌍 🌦️

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An advanced, premium weather dashboard application built with **Flutter**, following the **Clean Architecture** principles and **BLoC/Cubit** for state management. This project delivers a high-fidelity, interactive, and responsive user experience. 🚀

---

## ✨ Key Features

*   **Premium Interactive Dashboard**: Sleek and modern dark-themed user interface designed for optimal readability and aesthetic appeal. 💎
*   **Accurate Real-time Weather**: Get current weather conditions for any location around the globe.
*   **Precipitation Map**: Integrated visual maps to track rainfall and weather patterns. 🗺️
*   **Weekly Forecast**: Detailed 7-day weather predictions with high/low temperatures and conditions. 📅
*   **Adaptive Search Bar**: Quick location discovery with intelligent suggestions. 🔍
*   **Responsive Layouts**: Optimized for seamless performance on both mobile and desktop environments.

---

## 🛠️ Tech Stack & Architecture

This application is engineered for scalability and maintainability:

*   **Framework**: [Flutter](https://flutter.dev)
*   **Language**: [Dart](https://dart.dev)
*   **State Management**: [Cubit (Flutter BLoC)](https://pub.dev/packages/flutter_bloc)
*   **Architecture**: **Clean Architecture** (Data, Domain, and Presentation layers)
*   **Design Pattern**: Repository Pattern, Dependency Injection.
*   **External APIs**: OpenWeatherMap / WeatherAPI (or equivalent).

---

## 📁 Project Structure

```text
lib/
├── core/                  # Global utilities, themes, and base classes
├── features/
│   └── weather/
│       ├── data/          # Models, Data Sources & Repository Implementations
│       ├── domain/        # Entities, Repositories (Interfaces) & Use Cases
│       └── presentation/  # Blocs/Cubits, Pages & Widgets
└── main.dart              # Application entry point
```

---

## 🚀 Getting Started

### Prerequisites

*   Flutter SDK (^3.11.0)
*   Dart SDK
*   Android Studio / VS Code

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/garaahmad/Weather.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the application**:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution

Contributions are welcome! If you have suggestions or want to add a feature:
1.  Fork the project.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Developed with ❤️ by [Ahmed Gara](https://github.com/garaahmad)
