# PassWiz

A Flutter app that tells you how strong a password really is. It estimates how long a brute-force attack would take to crack it and calculates its entropy, with instant feedback as you type.

## Features

- **Strength analysis**: live rating while you type, with a visual strength indicator.
- **Brute-force crack time**: estimated time to crack the password.
- **Entropy calculation**: measures how random the password is.
- **Condition checklist**: shows which rules (length, case, digits, symbols) are met.
- **Copy button** and a clean, responsive UI for mobile and web.

## Tech stack

- Flutter and Dart
- `google_fonts`, `font_awesome_flutter`, `lottie` for UI and animation
- Custom entropy and crack-time logic in `lib/models/password_entropy.dart`

## Project structure

```
lib/
  main.dart
  models/    password_entropy.dart (entropy and crack-time logic)
  screens/   splash_screen.dart, home_screen.dart
  theme/     app_theme.dart
  widgets/   password_input_field, strength_indicator, condition_indicator, copy_button
```

## Getting started

```bash
flutter pub get
flutter run
```

Requires Flutter with Dart SDK 3.8 or newer.
