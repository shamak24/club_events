# 🦊 Mozilla FireFox Club Events App

A Flutter application for managing and viewing club events.

## ⬇️ Download

🔗 [Download Latest Release](https://github.com/shamak24/club_events/releases/latest)

The app is available for Android users through GitHub releases. Simply download the APK file from the latest release and install it on your Android device.

## 🛠️ Tech Stack

- **Flutter**: UI framework for cross-platform development
- **Dart**: Programming language
- **Riverpod**: State management solution
- **Hive**: Local database for persistence
- **flutter_launcher_icons**: App icon generation and management

## ✨ Features

- 📅 View upcoming club events
- ✨ Modern, minimalist UI design
- ❤️ Favorite events functionality
- 🎯 Create and manage events
- 📱 Responsive design
- 💾 Local data persistence

## 🚀 Getting Started

### 📋 Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android emulator or iOS simulator

### 💻 Installation

1. Clone the repository
```bash
git clone https://github.com/shamak24/club_events.git
```

2. Navigate to project directory
```bash
cd club_events
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 📊 State Management

This project uses **Riverpod** for state management. Riverpod was chosen for several reasons:

- **Type Safety**: Provides compile-time safety and better IDE support
- **Dependency Injection**: Built-in dependency injection capabilities
- **Code Organization**: Better code organization with providers
- **Testing**: Easier to test compared to other solutions
- **Performance**: Efficient rebuilds and better performance

### 🏗️ Provider Structure

The app uses a combination of Riverpod and Hive for state management and persistence:

- `eventBoxProvider`: A Provider that gives access to the Hive box storing events
  ```dart
  final eventBoxProvider = Provider<Box<Event>>((ref) {
    return Hive.box<Event>("events");
  });
  ```

- `eventListProvider`: A StateNotifierProvider that manages the list of events
  ```dart
  final eventListProvider = StateNotifierProvider<EventNotifier, List<Event>>((ref) {
    final box = ref.watch(eventBoxProvider);
    return EventNotifier(box);
  });
  ```

- `EventNotifier`: State notifier class that handles CRUD operations:
  - Add new events with UUID generation
  - Update existing events
  - Delete events
  - Automatically persists changes to Hive storage

## 🎯 Extra Features

### 1. ❤️ Favorites System
- Mark events as favorites
- Filter events by favorites
- Persistent favorite status

### 2. 💾 Data Persistence
- Events are stored locally using shared preferences
- Automatic data loading and saving
- Offline capability

### 3. 🎨 UI/UX Features
- Custom date formatting
- Material 3 design implementation
- Responsive layout adapting to different screen sizes

### 4. 📝 Event Management
- Create new events
- Delete events
- Add events to favorites

## 📁 Project Structure

```
lib/
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
└── widgets/        # Reusable widgets
|__ main.dart        # Entry point
```