# Reflex Flutter App 📱

The interactive mobile, desktop, and web frontend for **Reflex**, built with Flutter.

---

## 🎨 Architectural Design

Reflex follows the **Feature-First MVVM State-Controller** pattern (inspired by [arch_demo](https://github.com/khaled45690/arch_demo)), utilizing Flutter's native `setState()`:

- **State-Controllers:** Abstract controllers inheriting from `State<T>` encapsulating state variables, asynchronous action handlers, and lifecycle methods without any widget UI code.
- **Declarative Views:** Screen widgets purely expressing layout, typography, animations, and child widgets.

```text
lib/
├── core/
│   ├── result.dart                       # Result<T> functional return type
│   └── usecase.dart                      # UseCase<Type, Params> contract
│
├── data/
│   └── client/client.dart                # Serverpod client singleton
│
├── presentation/
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart           # Chromatic aura palette & surface tokens
│   │       └── app_theme.dart            # Material 3 dark & light themes
│   │
│   └── features/
│       ├── auth/                         # Sign in & learner authentication
│       ├── practice/                     # Flashcards, chromatic aura & note gate
│       ├── analytics/                    # Teacher cohort mastery dashboard
│       ├── question_admin/               # Teacher topic note & hint editor
│       └── greetings/                    # Greeting verification screen
│
└── assets/translations/
    ├── en.json                           # English strings (100% tr() covered)
    └── ar.json                           # Arabic strings (RTL supported)
```

---

## 🌈 Chromatic Reflex Aura Feedback

When submitting answers, Reflex displays a chromatic aura surrounding the flashcard:
- 🟢 **`ReflexColors.chromaticGreen` (#10B981):** Clean first-try solve under expected time.
- 🟡 **`ReflexColors.chromaticYellow` (#F59E0B):** Developing (slow response or hint requested).
- 🔴 **`ReflexColors.chromaticRed` (#EF4444):** Needs work (incorrect answer).

---

## 🌍 Localization

Reflex is 100% localized with zero hardcoded UI strings using `easy_localization`:

```bash
# Regenerate locale keys after editing translation files
fvm flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
```

---

## 🚀 Running the App

```bash
# Run on Chrome
fvm flutter run -d chrome

# Run on macOS Desktop
fvm flutter run -d macos
```
