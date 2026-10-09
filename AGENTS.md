# Reflex: AI Pair Programming & Engineering Guidelines

This project is **Reflex**, an intelligent, spaced-repetition speed recall platform for students and teachers, built for the Serverpod Hackathon 2026.

---

## 1. Stack & Architecture

- **Backend:** Serverpod 4.0.4 (`reflex_server`)
- **Shared Client:** Generated Serverpod RPC client (`reflex_client`)
- **Frontend:** Flutter (`reflex_flutter`) with MVVM pattern
- **Error Tracking:** Sentry Cloud integration across both Serverpod and Flutter
- **Localization:** `easy_localization` (English and Arabic RTL, zero static strings)

### 1.1 Server Architecture (Controller -> Service -> Repository)
1. **Endpoints (Thin Controllers):** Located in `reflex_server/lib/src/endpoints/`.
   - Strictly perform scope validation (`requiredScopes`), session extraction, and delegating to services.
   - Keep methods under 25 lines. Never write SQL or complex business formulas inside Endpoints.
2. **Services (Domain Logic):** Located in `reflex_server/lib/src/services/` and `src/domain/`.
   - Pure Dart classes (`PracticeService`, `Grader`, `AttemptOutcomeCalculator`, `CardSelector`, `CohortStatsService`).
   - Driven by Unit Tests with in-memory fake repositories (`test/fakes/fake_repositories.dart`).
3. **Repositories (Persistence & Atomic SQL):** Located in `reflex_server/lib/src/repositories/`.
   - The ONLY layer touching the database.
   - Atomic increments for Question counters use `session.db.unsafeExecute` inside transaction blocks.

### 1.2 Flutter Architecture (MVVM + Command Pattern)
- **Views:** Declarative widgets. Observe ViewModels, bind to `LocaleKeys.*.tr()`. Zero business logic.
- **ViewModels:** Subclasses of `ChangeNotifier`. Expose sealed `PracticeUiState` and `Command` objects.
- **Repositories:** Interfaces returning `Result<T>` (`Ok<T>`, `Error<T>`).
- **Chromatic Feedback:** UI dynamically tints answer cards and background to:
  - 🟢 **Emerald Green (`#10B981`):** `ReflexTier.greenMastered` (fast, correct, no help, 1st attempt).
  - 🟡 **Amber Yellow (`#F59E0B`):** `ReflexTier.yellowDeveloping` (correct, but slow or helped).
  - 🔴 **Crimson Red (`#EF4444`):** `ReflexTier.redNeedsWork` (inaccurate attempt).

### 1.3 Pedagogical Features & Security Rules
- **Multiple-Choice Questions (MCQ):** Questions can be `multipleChoice` or `textInput`.
- **Zero-Leakage Security Contract:**
  - `QuestionView` options list contains ONLY `id` and `text`. Never leak `isCorrect` or `explanation` before submission.
  - `SubmitResult` returns `selectedOptionExplanation`, `optionExplanations`, `reflexTier`, and `topicNote`.
- **Post-Submission Topic Note Gate:**
  - If a topic note or option explanation is present, the student MUST read and tap "✓ I have read the explanation and note" (`acknowledgeNote()`) before the "Continue to Next Card" button is unlocked.

---

## 2. Serverpod Tooling & MCP Operations

The user starts the server and Flutter app with `serverpod start` (or Docker for production).

- NEVER edit generated code (`lib/src/generated/` and `reflex_client/`). Change `.spy.yaml` models instead.
- Run `serverpod generate` when models or endpoints change.
- Run `serverpod create-migration` when database tables change.
- Tests manage their own test database: run `dart test` inside `reflex_server`.

---

## 3. Mandatory Check Before Committing
Run the project check script:
```bash
bash tool/check.sh
```
All analysis and tests across server, client, and flutter must pass with 0 warnings.
