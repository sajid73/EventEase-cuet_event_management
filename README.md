# CUET Event Management

A Flutter app to create, discover, and manage events for the CUET community.

## Quick start

Prerequisites
- Flutter SDK (stable)
- Dart
- (Optional) Docker / dev container — this workspace runs in a dev container on Ubuntu 24.04.2 LTS.
- A Firebase project (the app initializes Firebase in `lib/main.dart`)

Get dependencies and run:
```sh
flutter pub get
flutter run        # or `flutter run -d linux` to run the desktop target
```

Run tests:
```sh
flutter test
```
Unit/widget tests live in `test/widget_test.dart`.

## Important files & entry points

- App entry / Firebase init: `MyApp` — `lib/main.dart`  
- State & data layer: `DataController` — `lib/controller/data_controller.dart`  
- Auth flow: `AuthController` — `lib/controller/auth_controller.dart`  
- Create event screen: `CreateEventView` — `lib/view/bottom_nav_bar/create_event.dart`  
- Event detail screen: `EventPageView` — `lib/view/event_page/event_page_view.dart`  
- Events list widgets: `EventsFeed` and `EventHome` — `lib/widgets/events_feed_widget.dart`, `lib/widgets/main_event_feed.dart`  
- Theme/colors: `AppColors` — `lib/utils/app_color.dart`  
- Desktop (Linux) build config: `linux/CMakeLists.txt` and `linux/my_application.cc`

## Firebase

The app initializes Firebase in `lib/main.dart`. Before running:
1. Create or use an existing Firebase project.
2. Update the Firebase options (API key, project ID, storage bucket) in the project as needed.
3. Ensure Authentication, Firestore, and Storage rules/permissions are configured for development.

## Features

- Email-based authentication and user profiles
- Create events with images/videos and thumbnails
- Events feed with approval flow and per-event pages
- PDF ticket generation
- Desktop packaging support for Linux

## Development notes

- The project uses GetX for state management and navigation (controllers live in `lib/controller/`).
- Media upload uses Firebase Storage (see upload functions in `DataController`).
- Newly created events are stored with `"approved": false` by default.
- This workspace is intended to run inside the provided dev container (Ubuntu 24.04.2 LTS).