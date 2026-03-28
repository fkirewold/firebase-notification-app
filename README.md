# Firebase Push Notification App

A Flutter application demonstrating push notification implementation using Firebase Cloud Messaging (FCM). This project serves as a learning resource and starting point for integrating notifications in mobile apps.

## Features

- Firebase Cloud Messaging integration
- Push notification handling in foreground, background, and terminated states
- Notification tap action handling
- Cross-platform support for Android and iOS

## Project Structure

```
lib/
├── main.dart                          # Application entry point
├── notification_page.dart             # Notification display page
└── core/
    └── utils/
        ├── firebase_messaging.dart    # Firebase messaging utilities
        └── local_notification_service.dart  # Local notification service
```

## Prerequisites

- Flutter SDK (version 3.0 or higher)
- Firebase account and project
- Android Studio or Xcode for platform-specific setup

## Setup & Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/fkirewold/firebase-notification-app.git
   cd firebase-notification-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and/or iOS apps to your project
   - Download `google-services.json` for Android and place it in `android/app/`
   - Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`
   - Run the following command to configure FlutterFire:
     ```bash
     flutterfire configure
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Usage

The app demonstrates receiving and handling push notifications. Send test notifications from the Firebase Console to see the functionality in action.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
