# Chat App | Flutter & Firebase

A Flutter chat app with private one-to-one conversations and group chats, built with Clean Architecture and Cubit state management, backed by Firebase Authentication and Cloud Firestore.

## Features

- Email/password registration, login and password-reset flow (Firebase Authentication).
- Onboarding shown on first open, persisted locally with `shared_preferences`.
- Home with bottom navigation: recent chats, people search and profile.
- Private one-to-one chats: real-time message streams ordered by timestamp, separate bubble styling for the current user and other senders, and formatted message times (`intl`, `timeago`).
- Group chats: create a group, pick members from registered users, and chat in real time; other members' bubbles show the sender's name.
- People search by name or email to start a new conversation.
- Presence: online / last-seen state maintained from the app lifecycle, login and logout.
- Profile: view and edit the display name, log out, or delete the account.

## Architecture

Clean Architecture per feature (`data` / `domain` / `presentation`): remote data sources, repository implementations, use cases, then Cubits (`flutter_bloc`). Dependency injection with `get_it`, error handling with `dart_either`, and a `BlocObserver` for state observation.

Firestore data model:

- `users/{uid}`: profile fields plus presence (`isOnline`, `lastSeen`).
- `chats/{chatId}`: a private conversation (`participants`, `lastMessage`, `lastMessageAt`), with messages in `chats/{chatId}/messages`.
- `groups/{groupId}`: a group (`name`, `members`, `createdBy`, `lastMessage`, `lastMessageAt`), with messages in `groups/{groupId}/messages`; group messages carry an optional `senderName`.

## Main packages

`firebase_core`, `firebase_auth`, `cloud_firestore`, `flutter_bloc`, `get_it`, `dart_either`, `shared_preferences`, `uuid`, `intl`, `timeago`, `flutter_svg`, `lottie`, `fluttertoast`, `flutter_native_splash` and `flutter_launcher_icons`.

## Getting started

Use a Flutter installation whose bundled Dart SDK satisfies `^3.12.0`, as declared in `pubspec.yaml` (package name `scholar_chat_proj`).

```bash
git clone https://github.com/RafatMohamed/chat_App.git
cd chat_App
flutter pub get
```

1. Configure your own Firebase project and regenerate `firebase_options.dart` / platform configuration.
2. Enable Email/Password authentication and create a Cloud Firestore database.
3. Apply Firestore rules covering `users`, `chats` (with `messages`) and `groups` (with `messages`), and create the composite index used by the chats and groups list query (`array-contains` on members plus `lastMessageAt` ordering); the app logs a direct index-creation link on first run.

After completing the configuration above:

```bash
flutter run
```

## Current scope and limitations

- `google_sign_in` is declared in `pubspec.yaml`, but no Google sign-in flow is wired up.
- File or image attachments and push notifications are not implemented.
- Group messages sent before sender-name support show no sender name (the field is optional, so older messages simply have none).
- This README describes source-code implementation. Builds, external services and user flows have not been run as part of this documentation review.
