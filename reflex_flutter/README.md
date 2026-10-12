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
│   ├── client/client.dart                # Serverpod client singleton
│   └── repositories/                     # Type-safe repository layer
│       ├── practice_repository.dart      # Serve cards, submit answer, request help
│       ├── analytics_repository.dart     # Cohort summaries & student progress
│       ├── question_admin_repository.dart# Teacher questions & concept notes
│       └── demo_clock_repository.dart    # Time machine offset controls
│
├── presentation/
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart           # Chromatic aura palette & surface tokens
│   │       └── app_theme.dart            # Material 3 dark & light themes
│   │
│   ├── shell/
│   │   └── app_shell.dart                # Master navigation shell with Time Machine & Language toggle
│   │
│   └── features/
│       ├── auth/                         # Entry screen: Persona selection & demo login
│       │   ├── widgets/role_card.dart    # Interactive Student vs Teacher role selection card
│       │   ├── controller/auth_controller.dart
│       │   └── auth_screen.dart
│       │
│       ├── practice/                     # Spaced repetition practicing experience
│       │   ├── widgets/
│       │   │   ├── chromatic_aura_card.dart     # 🔴🟡🟢 Animated tier aura glow
│       │   │   ├── multiple_choice_widget.dart  # MCQ with inline rationale explanations
│       │   │   ├── topic_note_gate_widget.dart  # Mandatory concept reading gate
│       │   │   ├── response_timer_widget.dart   # Expected vs elapsed time indicator
│       │   │   ├── help_bottom_sheet.dart       # Guided hint modal (+1 day penalty note)
│       │   │   ├── result_feedback_sheet.dart   # Verdict & reflex tier banner
│       │   │   └── deck_complete_widget.dart    # Review session complete celebration
│       │   ├── controller/practice_controller.dart
│       │   └── practice_screen.dart
│       │
│       ├── analytics/                    # Teacher Analytics Dashboard
│       │   ├── widgets/
│       │   │   ├── topic_mastery_bars.dart      # Progress bars per topic
│       │   │   ├── question_insights_table.dart # All 6 atomic question counters table
│       │   │   └── student_cohort_table.dart    # Student clean-first-try solves table
│       │   ├── controller/analytics_controller.dart
│       │   └── analytics_screen.dart
│       │
│       ├── question_admin/               # Teacher Topic Note & Hint Editor
│       │   ├── controller/question_admin_controller.dart
│       │   └── question_admin_screen.dart
│       │
│       ├── profile/                      # Student Self-Progress Screen
│       │   ├── controller/student_progress_controller.dart
│       │   └── student_progress_screen.dart
│       │
│       ├── demo_clock/                   # Spaced Repetition Time Machine
│       │   ├── widgets/demo_clock_widget.dart   # +1d, +2d, +30d evaluator chips
│       │   └── controller/demo_clock_controller.dart
│       │
│       └── greetings/                    # Greeting verification screen
│
└── assets/translations/
    ├── en.json                           # English strings (100% LocaleKeys covered)
    └── ar.json                           # Arabic strings (100% RTL supported)
```

---

## 🌈 Chromatic Reflex Aura Feedback

When submitting answers, Reflex displays a chromatic aura surrounding the flashcard:
- 🟢 **`ReflexColors.chromaticGreen` (#10B981):** Mastered (Clean first-try solve under expected time).
- 🟡 **`ReflexColors.chromaticYellow` (#F59E0B):** Developing (Slow response or hint requested).
- 🔴 **`ReflexColors.chromaticRed` (#EF4444):** Needs work (Incorrect answer, scheduled for tomorrow).

---

## 🔒 Compulsory Concept Note Gate

Before continuing to the next review card, if a question has a teacher-authored concept explanation (`topicNote`), the student must read and acknowledge the explanation ("I have read and understood this concept"). The **Continue** button remains strictly disabled until acknowledged.

---

## ⏰ Time Machine (Demo Clock)

Evaluators can simulate future spaced repetition review intervals without waiting real days:
- **`+1 Day`**: Fast-forwards to tomorrow to test wrong answers and cards with requested hints.
- **`+2 Days`**: Fast-forwards by 2 days to test cards solved with slow latency.
- **`+30 Days`**: Fast-forwards to next month to test cleanly mastered cards.
- **`Reset`**: Returns simulated clock back to current system time.

---

## 🌍 Localization & RTL

Reflex is 100% localized with zero hardcoded UI strings using `easy_localization`:
- **English (`en`)** and **Arabic (`ar`)** with complete RTL directionality flipping.

```bash
# Regenerate locale keys after editing translation files
fvm flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
fvm flutter pub run easy_localization:generate -S assets/translations -o codegen_loader.g.dart
```

---

## 🧪 Testing

```bash
# Run all unit and widget tests
fvm flutter test
```

---

## 🚀 Running & Building the App

### Cloud Endpoints (Serverpod Cloud)
- **Web:** [https://reflex.serverpod.space/](https://reflex.serverpod.space/)
- **API:** [https://reflex.api.serverpod.space/](https://reflex.api.serverpod.space/)
- **Insights:** [https://reflex.insights.serverpod.space/](https://reflex.insights.serverpod.space/)

### Web & Desktop
```bash
# Run on Chrome
fvm flutter run -d chrome

# Run on macOS Desktop
fvm flutter run -d macos
```

### Android (Emulator & Physical Devices)

#### Running in Development:
```bash
# Connect to local Serverpod backend via emulator:
adb reverse tcp:8080 tcp:8080
fvm flutter run -d android

# Connect to Serverpod Cloud backend:
fvm flutter run -d RMX2040 --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
```

#### Running in Release Mode on Physical Device:
```bash
# Run optimized release build directly on connected Android device:
fvm flutter run -d RMX2040 --release --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
```

#### Building Release APK & App Bundle:
```bash
# Build Release APK connecting to Serverpod Cloud:
fvm flutter build apk --release --dart-define=SERVER_URL=https://reflex.api.serverpod.space/

# Build App Bundle (.aab) for Google Play:
fvm flutter build appbundle --release --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
```
> The built APK is saved to `build/app/outputs/flutter-apk/app-release.apk`.

### iOS (Simulator & Physical Devices)

#### Running in Development:
```bash
# Run on iOS Simulator (connects to local backend at http://localhost:8080):
fvm flutter run -d ios

# Run on iOS Simulator connected to Serverpod Cloud:
fvm flutter run -d ios --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
```

#### Building Release for iOS:
```bash
# Build iOS release bundle (without code signing):
fvm flutter build ios --release --no-codesign --dart-define=SERVER_URL=https://reflex.api.serverpod.space/

# Build IPA archive for TestFlight / App Store:
fvm flutter build ipa --release --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
```

