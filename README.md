# Scholar Chat | Flutter & Firebase

A Flutter chat project with email/password authentication and a shared real-time message feed backed by Cloud Firestore.

## Features

- Email/password registration and login with Firebase Authentication.
- Password-reset email flow and password-visibility controls.
- Four main screens: login, registration, password reset and chat.
- Real-time message updates through Firestore snapshots, ordered by timestamp.
- Messages store text, sender email and a server timestamp.
- Separate message-bubble styling for the current user and other senders, with formatted message times.

## Structure and state management

Feature folders separate login, registration, password reset and chat. Cubits handle authentication and form state; a singleton `ChatService` handles message writes and exposes the Firestore stream.

## Main packages

`firebase_core`, `firebase_auth`, `cloud_firestore`, `flutter_bloc`, `intl` and `timeago`.

## Getting started

Use a Flutter installation whose bundled Dart SDK satisfies `^3.7.0`, as declared in `pubspec.yaml`.

```bash
git clone https://github.com/RafatMohamed/chat_App.git
cd chat_App
flutter pub get
```

1. Configure your own Firebase project and regenerate Firebase options/platform configuration.
2. Enable Email/Password authentication and create a Cloud Firestore database. The chat reads and writes a `messages` collection with `message`, `email` and `timestamp` fields.
3. Set Firestore rules for the intended audience. The current query reads a shared collection, not isolated private conversations.

After completing the configuration above:

```bash
flutter run
```

## Current scope and limitations

- `google_sign_in` is declared and imported, but no implemented Google sign-in call was found. It is not listed as a working feature.
- Private chat rooms, file attachments and push notifications are not implemented in the reviewed chat flow.
- This README describes source-code implementation. Builds, external services and user flows have not been run as part of this documentation review.

## Code guide

- [`lib/features/login/logic/login_cubit.dart`](lib/features/login/logic/login_cubit.dart)
- [`lib/features/register/logic/register_cubit.dart`](lib/features/register/logic/register_cubit.dart)
- [`lib/features/forget_password/model/forgetPassword_cubit.dart`](lib/features/forget_password/model/forgetPassword_cubit.dart)
- [`lib/features/chat/model/chat_service.dart`](lib/features/chat/model/chat_service.dart)
- [`lib/features/chat/views/chat_view.dart`](lib/features/chat/views/chat_view.dart)
