# Flashcard Quiz

A Flutter mobile application for creating and studying flashcards with gamification features.

## Features

- **Deck Management**: Create, edit, and delete study decks with custom emojis and colors
- **Flashcard Creation**: Add, edit, and delete flashcards with questions and answers
- **Study Mode**: Interactive flashcard quiz interface with Show/Hide answer functionality
- **Profile System**: Personalized user profile with streak tracking and score system
- **Gamification**: Earn points for studying and maintain daily streaks

## Preloaded Decks

The app comes with four preloaded study decks:
- **Flutter** - Mobile development concepts
- **Python** - Programming language fundamentals
- **General Knowledge** - Trivia and facts
- **DSA** - Data Structures and Algorithms

## Getting Started

### Prerequisites

- Flutter SDK (3.11.0 or higher)
- Dart SDK
- Android Studio/iOS Simulator or physical device

### Installation

```bash
flutter pub get
flutter run
```

## How Points Work

- View answers: +2 points
- Navigate to next/previous card: +1 point
- Add flashcard: +5 points
- Edit flashcard: +3 points

## Dependencies

- `shared_preferences`: Local data storage
- `cupertino_icons`: iOS-style icons

## Project Structure

```
lib/
├── main.dart           # App entry point and main flashcard screen
├── models/
│   ├── flashcard.dart  # Flashcard model
│   └── deck.dart       # Deck model
├── screens/
│   ├── deck_management_screen.dart
│   ├── deck_questions_screen.dart
│   ├── deck_flashcard_screen.dart
│   ├── profile_screen.dart
│   └── splash_screen.dart
└── services/
    └── profile_service.dart  # User profile and score management
```

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.