# Chatting App

A cross-platform chat application built with Flutter.

## Features

- Real-time messaging
- User authentication
- Chat rooms
- Responsive UI for mobile and desktop
- Firebase integration

## Screenshots

<!-- Add your screenshots here -->

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (usually included with Flutter)
- A Firebase project (for backend services)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Abdalrahman1723/chat-app.git
   cd chat-app
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Configure Firebase:**

   - Follow the [Firebase setup guide](https://firebase.flutter.dev/docs/overview) for iOS, Android, and web.
   - Replace the `firebase_options.dart` file with your own configuration if needed.

4. **Run the app:**
   ```bash
   flutter run
   ```

## Folder Structure

```
lib/
  firebase_options.dart         # Firebase config
  main.dart                    # App entry point
  screens/                     # App screens (auth, chat, splash)
  widgets/                     # Reusable widgets (chat message, message bubble, etc.)
assets/                        # Images and assets
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

## Links

- GitHub: [https://github.com/Abdalrahman1723/chat-app](https://github.com/Abdalrahman1723/chat-app)
