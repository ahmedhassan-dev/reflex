# Competition Scope Task Catalogue (v2)

> **Project:** Serverpod Education App Rebuild (Competition Slice)
> **Target Deadline:** October 14, 2026
> **Architecture:** Flutter MVVM | Serverpod Controller-Service-Repository | Sentry Monitoring | easy_localization | TDD

## Summary Statistics

- **Total Tasks:** 51
- **P0 (Blocker / Must Have):** 43 tasks (84.0 hours)
- **P1 (Core / Quality & Invariants):** 4 tasks (6.0 hours)
- **P2 (Stretch / Post-MVP):** 4 tasks (9.5 hours)
- **Total P0 + P1:** 90.0 hours (~11-12 work days or ~15 hours/day over 6 days)

---

## Task Quick Index

| ID | Title | Track | Priority | Day | Hours | Depends On |
|---|---|---|---|---|---|---|
| T-001 | Toolchain & SDK Setup: FVM & Serverpod CLI | Setup | P0 - Blocker | Day 1 (Oct 8) | 1.0h | - |
| T-002 | Docker & PostgreSQL Environment Verification | Setup | P0 - Blocker | Day 1 (Oct 8) | 0.5h | T-001 |
| T-003 | Scaffold Serverpod Fullstack Project (`reflex`) | Setup | P0 - Blocker | Day 1 (Oct 8) | 1.0h | T-002 |
| T-004 | Monorepo Conventions, Guidelines & Check Script | Setup | P0 - Blocker | Day 1 (Oct 8) | 1.0h | T-003 |
| T-005 | Dependency Setup across Server & Flutter | Setup | P0 - Blocker | Day 1 (Oct 8) | 0.5h | T-004 |
| T-010 | Serverpod Protocol Definitions: Entities & Enums | Serverpod (Backend) | P0 - Blocker | Day 1 (Oct 8) | 2.0h | T-005 |
| T-011 | Serverpod Protocol DTOs & Exception Hierarchy | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 1.0h | T-010 |
| T-012 | Clock & DemoClock Abstraction (TDD) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 1.5h | T-011 |
| T-013 | Answer Normalizer & Grader (TDD: Text & MCQ) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 1.5h | T-011 |
| T-014 | AttemptOutcomeCalculator & Reflex Tier Classifier (TDD) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 2.0h | T-013 |
| T-015 | Scheduling Policy Engine (TDD) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 1.5h | T-014 |
| T-016 | Repository Interfaces & In-Memory Fakes (TDD) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 1.5h | T-011 |
| T-017 | Card Selector & Review Queue Engine (TDD) | Serverpod (Backend) | P0 - Blocker | Day 2 (Oct 9) | 2.0h | T-016 |
| T-018 | Database Repositories & Atomic Counter SQL (Serverpod ORM) | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 3.0h | T-010, T-016 |
| T-019 | PracticeService Implementation & Idempotency (TDD) | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 3.0h | T-014, T-017, T-018 |
| T-020 | CohortStatsService & Insights Aggregator (TDD) | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 2.5h | T-018 |
| T-021 | QuestionAdminService (Teacher Topic Notes & Hints) | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 1.0h | T-018 |
| T-022 | Authentication, Scopes & Learner Mapping | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 2.5h | T-018 |
| T-023 | Endpoints Layer (Thin MVC Controllers) & AppContainer | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 2.5h | T-019, T-020, T-021, T-022 |
| T-024 | Serverpod Integration Tests (`withServerpod`) | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 3.0h | T-023 |
| T-025 | Concurrency & Invariant Verification Test | Serverpod (Backend) | P1 - Core | Day 3 (Oct 10) | 1.5h | T-024 |
| T-026 | Seed Script & Demo Cohort Generator | Serverpod (Backend) | P0 - Blocker | Day 3 (Oct 10) | 2.0h | T-023 |
| T-030 | ErrorReporter Abstraction & Serverpod Sentry Integration | Monitoring | P0 - Blocker | Day 3 (Oct 10) | 1.5h | T-005 |
| T-031 | Flutter Sentry Setup & Sensitive Data Scrubbing | Monitoring | P0 - Blocker | Day 4 (Oct 11) | 1.5h | T-005 |
| T-032 | Diagnostic Error Simulation Endpoint & Debug UI | Monitoring | P1 - Core | Day 4 (Oct 11) | 1.0h | T-030, T-031 |
| T-040 | Flutter App Shell, Dependency Injection & Routing | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 2.0h | T-005 |
| T-041 | MVVM Base Infrastructure: `Command` & `Result` Types | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 1.0h | T-040 |
| T-042 | Flutter Data Layer: Repositories & Serverpod Client Wrapper | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 2.5h | T-041 |
| T-043 | `easy_localization` Setup, JSON Dictionaries & Codegen | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 2.0h | T-005 |
| T-044 | Hardcoded String Guard Unit Test | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 1.0h | T-043 |
| T-045 | AuthViewModel & Login/Register Screen | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 2.5h | T-042, T-043 |
| T-046 | PracticeViewModel (TDD with Mocktail) | Flutter (Client) | P0 - Blocker | Day 4 (Oct 11) | 3.0h | T-042 |
| T-047 | Practice Screen & Widgets (Question Card, Multiple Choice, Chromatic Aura, Note Gate) | Flutter (Client) | P0 - Blocker | Day 5 (Oct 12) | 4.0h | T-046, T-043 |
| T-048 | Practice Screen Widget Tests (TDD) | Flutter (Client) | P1 - Core | Day 5 (Oct 12) | 2.0h | T-047 |
| T-049 | Student Self-Progress Card & Profile Screen | Flutter (Client) | P1 - Core | Day 5 (Oct 12) | 1.5h | T-042, T-043 |
| T-050 | Teacher Topic Note, Option & Hint Editor Screen | Flutter (Client) | P0 - Blocker | Day 5 (Oct 12) | 3.0h | T-042, T-043 |
| T-051 | Teacher Analytics Dashboard (Cohort Mastery, Question Insights, Student Table) | Flutter (Client) | P0 - Blocker | Day 5 (Oct 12) | 4.0h | T-042, T-043 |
| T-052 | Demo Clock Control Widget | Flutter (Client) | P0 - Blocker | Day 5 (Oct 12) | 1.0h | T-040, T-043 |
| T-053 | Arabic Localization & RTL Visual Polish | Flutter (Client) | P0 - Blocker | Day 5 (Oct 12) | 1.5h | T-043, T-047, T-050, T-051 |
| T-060 | Backend Deployment (Serverpod Cloud / Railway / Docker) | DevOps & Submission | P0 - Blocker | Day 6 (Oct 13) | 3.0h | T-023, T-026 |
| T-061 | Flutter Web / Android APK Production Build | DevOps & Submission | P0 - Blocker | Day 6 (Oct 13) | 2.0h | T-060 |
| T-062 | Automated End-to-End Smoke Test Script | DevOps & Submission | P0 - Blocker | Day 6 (Oct 13) | 1.5h | T-060 |
| T-063 | Project Documentation, ARCHITECTURE.md & README.md | DevOps & Submission | P0 - Blocker | Day 6 (Oct 13) | 1.5h | T-004 |
| T-064 | Final UML Diagrams Export & Verification | DevOps & Submission | P0 - Blocker | Day 6 (Oct 13) | 1.0h | - |
| T-065 | Demo Video Recording & Script (3-Minute Walkthrough) | DevOps & Submission | P0 - Blocker | Day 7 (Oct 14) | 3.0h | T-061, T-062 |
| T-066 | Submission Tag & Checklist Verification | DevOps & Submission | P0 - Blocker | Day 7 (Oct 14) | 1.0h | T-065 |
| T-067 | Competition Buffer & Bug Triage | DevOps & Submission | P0 - Blocker | Day 7 (Oct 14) | 4.0h | T-066 |
| T-070 | French Localization (`fr.json`) | Stretch | P2 - Stretch | Post-P0/P1 | 2.0h | T-043 |
| T-071 | Realtime Dashboard via Serverpod Streaming Methods | Stretch | P2 - Stretch | Post-P0/P1 | 3.0h | T-023, T-051 |
| T-072 | DueDigest Scheduled Task via FutureCall | Stretch | P2 - Stretch | Post-P0/P1 | 2.5h | T-010 |
| T-073 | Sentry Distributed Performance Tracing | Stretch | P2 - Stretch | Post-P0/P1 | 2.0h | T-030, T-031 |

---

## Detailed Task Specifications

### `T-001` - Toolchain & SDK Setup: FVM & Serverpod CLI

- **Track:** Setup
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 1.0 hours

> **Goal:** Verify and install the required Dart, Flutter, and Serverpod CLI versions for Serverpod 4.0.4 (or fallback to 3.4.0 if toolchain constraints require).

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `dart --version` and verify Dart >= 3.9.0 (target: 3.12+ for 4.0.4 or 3.9+ for 3.4.0)`
- [ ] `Run `serverpod --version` after `dart pub global activate serverpod_cli``

#### 🛠️ Implementation Steps
1. Check local Flutter and Dart versions using FVM.
2. If Flutter >= 3.44.4 is available, activate Serverpod CLI 4.0.4 (`dart pub global activate serverpod_cli 4.0.4`).
3. If constrained to local Flutter 3.35.2 / Dart 3.9.0, use Serverpod CLI 3.4.0 (`dart pub global activate serverpod_cli 3.4.0`).
4. Ensure ~/.pub-cache/bin is in PATH.
5. Verify `serverpod --version` executes cleanly.

#### 📁 Files to Create / Modify
- `.fvmrc`
- `pubspec.yaml`

#### ✅ Acceptance Criteria
- [ ] `serverpod` CLI is installed and returns version cleanly.
- [ ] Target Serverpod framework version is explicitly locked.

> ⚠️ **Gotchas & References:** Serverpod 4.0.4 requires Dart ^3.12.2 and Flutter ^3.44.4. If host cannot update Flutter today, Serverpod 3.4.0 is fully capable for this hackathon slice.

---

### `T-002` - Docker & PostgreSQL Environment Verification

- **Track:** Setup
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 0.5 hours
- **Depends On:** T-001

> **Goal:** Ensure Docker engine is active so Serverpod local Postgres container can start seamlessly.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `docker info` to verify daemon responsiveness`
- [ ] `Verify port 8090 (Postgres) is not bound by legacy processes`

#### 🛠️ Implementation Steps
1. Start Docker Desktop on macOS.
2. Confirm `docker ps` returns without daemon connection errors.
3. Check `lsof -i :8090` and `lsof -i :8080` to avoid port collisions.

#### 📁 Files to Create / Modify
- *(None)*

#### ✅ Acceptance Criteria
- [ ] Docker daemon is running.
- [ ] Ports 8080, 8081, 8090 are free.

> ⚠️ **Gotchas & References:** Serverpod uses port 8090 for local Postgres and 8080/8081 for API and web server.

---

### `T-003` - Scaffold Serverpod Fullstack Project (`reflex`)

- **Track:** Setup
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 1.0 hours
- **Depends On:** T-002

> **Goal:** Create a clean Serverpod fullstack project (`reflex`) with Antigravity IDE configuration.

#### 🧪 Tests First (TDD Specification)
- [ ] `Validate that `docker compose up -d` in server directory starts the Postgres container`
- [ ] `Run `dart run bin/main.dart --mode development` and verify it binds to port 8080`

#### 🛠️ Implementation Steps
1. Execute `serverpod create reflex --template fullstack --ide antigravity`.
2. Verify generated packages: `reflex_server`, `reflex_client`, and `reflex_flutter`.
3. Initialize clean git repository for the new project.
4. Test starting local Postgres via `docker compose up -d` in the server project.

#### 📁 Files to Create / Modify
- `reflex/reflex_server/pubspec.yaml`
- `reflex/reflex_client/pubspec.yaml`
- `reflex/reflex_flutter/pubspec.yaml`

#### ✅ Acceptance Criteria
- [ ] Three packages created without errors.
- [ ] Local database starts and migrations run.
- [ ] Antigravity IDE configuration files created.

> ⚠️ **Gotchas & References:** Do NOT scaffold inside the legacy Flutter repo root; create in a clean directory or designated subfolder.

---

### `T-004` - Monorepo Conventions, Guidelines & Check Script

- **Track:** Setup
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 1.0 hours
- **Depends On:** T-003

> **Goal:** Establish AGENTS.md instructions, strict analysis options, and a single validation script (`tool/check.sh`).

#### 🧪 Tests First (TDD Specification)
- [ ] `Execute `bash tool/check.sh` on fresh scaffold and ensure exit code 0`

#### 🛠️ Implementation Steps
1. Create AGENTS.md specifying MVVM on Flutter, Controller-Service-Repository on Serverpod, Sentry rules, and easy_localization rules.
2. Configure analysis_options.yaml with `prefer_const_constructors`, `avoid_print`, and strict types.
3. Create `tool/check.sh` running `dart analyze`, `flutter test`, and `serverpod test`.
4. Make `tool/check.sh` executable (`chmod +x tool/check.sh`).

#### 📁 Files to Create / Modify
- `AGENTS.md`
- `analysis_options.yaml`
- `tool/check.sh`

#### ✅ Acceptance Criteria
- [ ] `bash tool/check.sh` executes analysis and test runner across packages.

> ⚠️ **Gotchas & References:** AGENTS.md guides future LLM agents working on the codebase to avoid architectural drift.

---

### `T-005` - Dependency Setup across Server & Flutter

- **Track:** Setup
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 0.5 hours
- **Depends On:** T-004

> **Goal:** Add all required third-party packages with verified versions across client, server, and flutter apps.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `dart pub get` in server and `flutter pub get` in flutter`

#### 🛠️ Implementation Steps
1. Server: add `sentry: ^9.30.1`, `test: ^1.25.0`, `mocktail: ^1.0.5`.
2. Flutter: add `easy_localization: ^3.0.8`, `sentry_flutter: ^9.30.1`, `provider: ^6.1.5`, `go_router: ^18.0.2`, `mocktail: ^1.0.5`.
3. Run pub get and resolve any conflicts.

#### 📁 Files to Create / Modify
- `education_saas_server/pubspec.yaml`
- `education_saas_flutter/pubspec.yaml`

#### ✅ Acceptance Criteria
- [ ] All dependencies resolve cleanly with zero pub errors.

> ⚠️ **Gotchas & References:** Keep versions pinned to avoid breaking API changes during competition week.

---

### `T-010` - Serverpod Protocol Definitions: Entities & Enums

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 1 (Oct 8)
- **Estimate:** 2.0 hours
- **Depends On:** T-005
- **User Stories:** US-160, US-162, US-163

> **Goal:** Define Serverpod YAML models for Course, Question (with 6 counters, questionType, topicNote, helpHint), QuestionOption (isCorrect, explanation), AcceptedAnswer, Learner, Attempt (reflexTier, selectedOptionId), ReviewState, DemoClock.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `serverpod generate` and verify all generated protocol classes compile cleanly`
- [ ] `Run `serverpod create-migration` and verify SQL schema has required columns and indexes`

#### 🛠️ Implementation Steps
1. Define enums: `Role` (student, teacher), `AttemptStatus` (valid, wrong), `ResultReason` (correctClean, correctSlow, correctWithHelp, wrong), `QuestionType` (textInput, multipleChoice), `ReflexTier` (greenMastered, yellowDeveloping, redNeedsWork).
2. Define `Course` table (title, subject).
3. Define `Question` table with fields: `courseId: int`, `position: int`, `prompt: String`, `topic: String`, `questionType: QuestionType`, `points: int`, `expectedSeconds: int`, `topicNote: String?`, `helpHint: String?`, and the 6 counters (`attemptCount`, `attemptedStudentCount`, `solvedStudentCount`, `firstTrySolveCount`, `underTimeSolveCount`, `cleanSolveCount`).
4. Define `QuestionOption` table: `questionId: int`, `position: int`, `text: String`, `isCorrect: bool`, `explanation: String?` (explaining why this choice was right or wrong!).
5. Define `AcceptedAnswer` table (`questionId: int`, `normalizedText: String`).
6. Define `Learner` table (`authUserId: UuidValue`, `displayName: String`, `role: Role`).
7. Define `Attempt` table (`learnerId: int`, `questionId: int`, `selectedOptionId: int?`, `answerText: String?`, `status: AttemptStatus`, `responseMs: int`, `usedHelp: bool`, `isFirstAttempt: bool`, `underExpectedTime: bool`, `isClean: bool`, `reflexTier: ReflexTier`, `createdAt: DateTime`).
8. Define `ReviewState` table (`learnerId: int`, `questionId: int`, `dueAt: DateTime`, `intervalDays: int`, `lapses: int`, `helpUsed: bool`, `lastServedAt: DateTime?`, `lastResult: AttemptStatus?`). Unique index on (learnerId, questionId).
9. Define `DemoClock` table (`offsetDays: int`).
10. Run `serverpod generate` and `serverpod create-migration`.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/models/course.spy.yaml`
- `education_saas_server/lib/src/models/question.spy.yaml`
- `education_saas_server/lib/src/models/accepted_answer.spy.yaml`
- `education_saas_server/lib/src/models/learner.spy.yaml`
- `education_saas_server/lib/src/models/attempt.spy.yaml`
- `education_saas_server/lib/src/models/review_state.spy.yaml`
- `education_saas_server/lib/src/models/demo_clock.spy.yaml`
- `education_saas_server/lib/src/models/enums.spy.yaml`
- `reflex_server/lib/src/models/question_option.spy.yaml`

#### ✅ Acceptance Criteria
- [ ] All models generate without warnings.
- [ ] Migration file contains all table definitions, nullable fields, and unique index on ReviewState.

> ⚠️ **Gotchas & References:** Question must have all 6 counters initialized to 0. ReviewState requires nullable `lastServedAt` to support idempotency.

---

### `T-011` - Serverpod Protocol DTOs & Exception Hierarchy

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 1.0 hours
- **Depends On:** T-010
- **User Stories:** US-160, US-161, US-162, US-163, US-164

> **Goal:** Create DTOs for MCQ options (QuestionOptionView without answer/notes), post-submission option explanations (OptionExplanationView), SubmitResult with ReflexTier, and typed exceptions.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit test verifying QuestionView class has no `answerKey` or `topicNote` fields`
- [ ] `Unit test verifying SubmitResult serializes `ResultReason` and `topicNote``

#### 🛠️ Implementation Steps
1. Define `QuestionOptionView` (id, text) - never include isCorrect or explanation here!
2. Define `OptionExplanationView` (optionId, text, isCorrect, explanation) - returned ONLY in SubmitResult.
3. Define `QuestionView` (id, prompt, topic, questionType, List<QuestionOptionView>? options, points, expectedSeconds, hasHelpHint).
4. Define `SubmitResult` (verdict, reason, reflexTier, points, responseMs, nextDueAt, topicNote, selectedOptionExplanation, List<OptionExplanationView>? optionExplanations).
5. Define `HelpResult`, `CohortSummary`, `QuestionInsight`, `StudentProgress`, `TopicMastery`.
6. Create exception classes: `CardAlreadyAnsweredException`, `NoActiveCardException`, `QuestionNotFoundException`, `UnauthorizedException`.
7. Run `serverpod generate`.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/models/dtos.spy.yaml`
- `education_saas_server/lib/src/domain/exceptions.dart`

#### ✅ Acceptance Criteria
- [ ] DTOs generated.
- [ ] `QuestionView` physically lacks answer and topicNote fields to make leakage impossible at compile time.

> ⚠️ **Gotchas & References:** Security requirement: the topic note must only be provided after submission, not in PracticeItem.

---

### `T-012` - Clock & DemoClock Abstraction (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 1.5 hours
- **Depends On:** T-011

> **Goal:** Implement testable Clock interface and DemoClockService allowing deterministic time advancement for hackathon judging.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('SystemClock returns DateTime.now()')`
- [ ] `test('FakeClock allows manual setNow and advanceBy')`
- [ ] `test('DemoClockService adds offsetDays to current time')`
- [ ] `test('DemoClockService advanceDays(N) increments offset and updates time')`

#### 🛠️ Implementation Steps
1. Write `test/unit/clock_test.dart` asserting all time manipulation behaviors.
2. Create `Clock` abstract class with `DateTime now()`.
3. Implement `SystemClock` using `DateTime.now()`.
4. Implement `FakeClock` with `setNow(DateTime dt)` and `advance(Duration d)` for unit tests.
5. Implement `DemoClockService` wrapping `Clock` and persisting offset in DemoClock repo.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/domain/clock.dart`
- `education_saas_server/lib/src/services/demo_clock_service.dart`
- `education_saas_server/test/unit/clock_test.dart`

#### ✅ Acceptance Criteria
- [ ] Clock unit tests pass 100%.
- [ ] Demo clock allows shifting days without altering host machine time.

> ⚠️ **Gotchas & References:** Crucial for judging: allows demonstrating spaced repetition intervals (+1d, +2d, +30d) in seconds.

---

### `T-013` - Answer Normalizer & Grader (TDD: Text & MCQ)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 1.5 hours
- **Depends On:** T-011

> **Goal:** Build answer grader supporting text normalization (Arabic digits, diacritics, numeric equivalence) AND multiple-choice option evaluation.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('normalizes leading/trailing and inner whitespace: "  x   y  " -> "x y"')`
- [ ] `test('case insensitivity: "Paris" matches "paris"')`
- [ ] `test('Arabic-Indic digits normalization: "١٢" matches "12"')`
- [ ] `test('Arabic diacritics removal: "مُعَلِّم" matches "معلم"')`
- [ ] `test('numeric equivalence: "5" matches "5.0" and "5.00"')`
- [ ] `test('empty answer returns AttemptStatus.wrong without crashing')`
- [ ] `test('MCQ evaluation: returns AttemptStatus.valid when selected option isCorrect=true')`
- [ ] `test('MCQ evaluation: returns AttemptStatus.wrong when selected option isCorrect=false')`

#### 🛠️ Implementation Steps
1. Write `test/unit/grader_test.dart` covering all normalization cases.
2. Implement `AnswerNormalizer.normalize(String raw)` handling trim, lowerCase, regex replace for Arabic numerals, diacritics, and numeric parsing.
3. Implement `Grader.grade(String studentAnswer, List<String> acceptedAnswers)` returning `AttemptStatus`.
4. Implement `Grader.gradeOption(QuestionOption option)` returning `AttemptStatus`.
5. Ensure Grader seamlessly branches between text grading and option evaluation.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/domain/grader.dart`
- `education_saas_server/test/unit/grader_test.dart`

#### ✅ Acceptance Criteria
- [ ] All unit test cases pass.
- [ ] Arabic and numeric equivalence work seamlessly.

> ⚠️ **Gotchas & References:** Important for Africa context: students frequently submit Arabic-Indic digits ('١','٢','٣') or varying diacritics.

---

### `T-014` - AttemptOutcomeCalculator & Reflex Tier Classifier (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 2.0 hours
- **Depends On:** T-013
- **User Stories:** US-160, US-162, US-163, US-164

> **Goal:** Domain logic calculating verdict, reason, next interval, counter deltas, and classifying into ReflexTier (Green = Clean/Fast, Yellow = Slow/Helped, Red = Wrong).

#### 🧪 Tests First (TDD Specification)
- [ ] `test('wrong answer gives ResultReason.wrong, interval +1d, lapses+1')`
- [ ] `test('correct with help gives ResultReason.correctWithHelp, interval +1d, lapses unchanged, isClean false')`
- [ ] `test('correct without help but slow gives ResultReason.correctSlow, interval +2d, isClean false')`
- [ ] `test('correct without help, first attempt, under time gives ResultReason.correctClean, interval +30d, isClean true')`
- [ ] `test('boundary: responseMs == expectedSeconds*1000 counts as underExpectedTime')`
- [ ] `test('calculates correct question counter deltas: attemptCount+1, attemptedStudentCount+1 on first attempt, solvedStudentCount+1 on first valid, cleanSolveCount+1 on clean')`
- [ ] `test('valid + fast + no help + 1st try maps to ReflexTier.greenMastered (+30d)')`
- [ ] `test('valid + slow maps to ReflexTier.yellowDeveloping (+2d)')`
- [ ] `test('valid + helped maps to ReflexTier.yellowDeveloping (+1d)')`
- [ ] `test('wrong answer maps to ReflexTier.redNeedsWork (+1d)')`

#### 🛠️ Implementation Steps
1. Write `test/unit/attempt_outcome_test.dart` with parameterized matrix of all conditions.
2. Implement `AttemptOutcomeCalculator.evaluate(...)` returning structured outcome object.
3. Implement delta calculator for the 6 Question counters based on previous learner attempts.
4. Classify attempt outcome into `ReflexTier` enum.
5. Attach `reflexTier` to attempt entity for dashboard reporting.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/domain/attempt_outcome.dart`
- `education_saas_server/test/unit/attempt_outcome_test.dart`

#### ✅ Acceptance Criteria
- [ ] 100% test coverage on outcome logic.
- [ ] Zero coupling to database in this pure calculation class.

> ⚠️ **Gotchas & References:** Follow exact rules: help used caps interval to +1d; slow (> expected) caps interval to +2d; clean gives +30d.

---

### `T-015` - Scheduling Policy Engine (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 1.5 hours
- **Depends On:** T-014

> **Goal:** Port the legacy Iron Man fixed interval policy with full test coverage.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('LegacyFixedIntervalPolicy schedules wrong answer +1 day')`
- [ ] `test('LegacyFixedIntervalPolicy schedules helped answer +1 day')`
- [ ] `test('LegacyFixedIntervalPolicy schedules slow answer +2 days')`
- [ ] `test('LegacyFixedIntervalPolicy schedules clean answer +30 days')`

#### 🛠️ Implementation Steps
1. Define `SchedulingPolicy` interface (`DateTime nextDue(DateTime now, ResultReason reason)`).
2. Implement `LegacyFixedIntervalPolicy`.
3. Verify all edge cases in unit tests.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/domain/scheduling_policy.dart`
- `education_saas_server/test/unit/scheduling_policy_test.dart`

#### ✅ Acceptance Criteria
- [ ] Clean test execution for scheduling rules.

> ⚠️ **Gotchas & References:** Keeps competition logic 100% faithful to the original 2024 app rules while adding help constraint.

---

### `T-016` - Repository Interfaces & In-Memory Fakes (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 1.5 hours
- **Depends On:** T-011

> **Goal:** Create clean repository interfaces and in-memory fakes to allow pure unit testing of all services without database overhead.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit tests verifying fake repositories correctly support CRUD, queries, and atomic counter updates`

#### 🛠️ Implementation Steps
1. Create interfaces: `LearnerRepository`, `CourseRepository`, `QuestionRepository`, `AttemptRepository`, `ReviewStateRepository`, `ClockRepository`.
2. Implement `Fake*Repository` classes storing entities in memory `Map<int, T>`.
3. Implement simulated atomic counter increment methods in fake question repo.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/repositories/interfaces.dart`
- `education_saas_server/test/fakes/fake_repositories.dart`

#### ✅ Acceptance Criteria
- [ ] Fake repositories behave identically to DB contracts.
- [ ] Allows running 50+ service tests in milliseconds without Postgres.

> ⚠️ **Gotchas & References:** Foundation of fast TDD cycle. Real Serverpod DB repos will be wired in T-018.

---

### `T-017` - Card Selector & Review Queue Engine (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 2 (Oct 9)
- **Estimate:** 2.0 hours
- **Depends On:** T-016

> **Goal:** Card selection algorithm: due reviews first (ordered by dueAt ASC), then unattempted cards (by position ASC), else null.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('returns overdue review card first before any new cards')`
- [ ] `test('orders multiple overdue review cards by dueAt ascending')`
- [ ] `test('returns new unattempted card when no reviews are due')`
- [ ] `test('orders new cards by question.position ascending')`
- [ ] `test('returns null when all cards are scheduled in the future (deck complete)')`

#### 🛠️ Implementation Steps
1. Write `test/unit/card_selector_test.dart` using fake repositories.
2. Implement `CardSelector.selectNextCard(...)`.
3. Verify edge conditions (empty deck, all overdue, all completed).

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/domain/card_selector.dart`
- `education_saas_server/test/unit/card_selector_test.dart`

#### ✅ Acceptance Criteria
- [ ] Tests pass verifying strict prioritization of overdue cards over new cards.

> ⚠️ **Gotchas & References:** Prevents review pile-ups by always serving due cards first.

---

### `T-018` - Database Repositories & Atomic Counter SQL (Serverpod ORM)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 3.0 hours
- **Depends On:** T-010, T-016
- **User Stories:** US-163

> **Goal:** Implement real Serverpod database repositories, including atomic SQL increments for Question counters using `session.db.unsafeExecute`.

#### 🧪 Tests First (TDD Specification)
- [ ] `Integration test verifying atomic question counter update increments fields without overwriting concurrent updates`
- [ ] `Test CRUD operations across all entities via session.db`

#### 🛠️ Implementation Steps
1. Implement repository classes taking `Session` (and optional `Transaction`).
2. Implement `QuestionRepositoryImpl.applyCounterDeltas(...)` using `session.db.unsafeExecute` with parameterized SQL (`UPDATE question SET "attemptCount" = "attemptCount" + @dAttempts... WHERE id = @id`).
3. Implement ReviewState upsert and query methods.
4. Implement `QuestionOptionRepository` for querying and authoring question choices and explanations.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/repositories/serverpod_repositories.dart`
- `reflex_server/lib/src/repositories/option_repository.dart`

#### ✅ Acceptance Criteria
- [ ] All repository methods compile and map cleanly to Serverpod ORM.
- [ ] Raw SQL is properly parameterized against SQL injection.

> ⚠️ **Gotchas & References:** Serverpod ORM `updateWhere` does not support expression-based updates like `col = col + 1`. Raw SQL via `unsafeExecute` inside a transaction is the correct Serverpod pattern.

---

### `T-019` - PracticeService Implementation & Idempotency (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 3.0 hours
- **Depends On:** T-014, T-017, T-018
- **User Stories:** US-160, US-161, US-162, US-163

> **Goal:** Core practice workflow supporting MCQ and text answers, stamping lastServedAt, grading, atomic transaction, and returning SubmitResult with ReflexTier, option explanations, and topic note.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('serveNextCard stamps lastServedAt and resets helpUsed to false')`
- [ ] `test('requestHelp throws NoActiveCardException if no card currently served')`
- [ ] `test('requestHelp flags card as helpUsed and returns hint')`
- [ ] `test('submitAnswer throws CardAlreadyAnsweredException if card was already submitted (idempotency)')`
- [ ] `test('submitAnswer calculates latency from lastServedAt to now')`
- [ ] `test('submitAnswer persists Attempt, updates ReviewState, updates Question counters, and clears lastServedAt in transaction')`
- [ ] `test('submitAnswer returns SubmitResult containing topicNote and reason')`
- [ ] `test('submitAnswer with optionId evaluates option and returns optionExplanations')`
- [ ] `test('submitAnswer returns ReflexTier matching attempt speed and accuracy')`

#### 🛠️ Implementation Steps
1. Write `test/unit/practice_service_test.dart` using fake repos and fake clock.
2. Implement `PracticeService` coordinating CardSelector, Grader, AttemptOutcomeCalculator, and repositories.
3. Ensure `lastServedAt` is cleared on submission to reject duplicate submissions.
4. Load `OptionExplanationView` objects into `SubmitResult` to explain why choices were right or wrong.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/services/practice_service.dart`
- `education_saas_server/test/unit/practice_service_test.dart`

#### ✅ Acceptance Criteria
- [ ] All unit test cases pass.
- [ ] Double-submit is rejected with `CardAlreadyAnsweredException`.

> ⚠️ **Gotchas & References:** Topic note is attached to the returned `SubmitResult`. Client receives it only upon submission.

---

### `T-020` - CohortStatsService & Insights Aggregator (TDD)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 2.5 hours
- **Depends On:** T-018
- **User Stories:** US-163, US-164, US-165

> **Goal:** Service calculating CohortSummary for teacher dashboard and student self-progress (clean solves, mastery streak, question insights).

#### 🧪 Tests First (TDD Specification)
- [ ] `test('aggregates question insights correctly from Question entity counters')`
- [ ] `test('calculates studentProgress including cleanFirstTryCount and solvedCount')`
- [ ] `test('calculates topicMastery rate as percentage of mastered cards')`

#### 🛠️ Implementation Steps
1. Write unit tests with synthetic learner and attempt datasets.
2. Implement `CohortStatsService.getCohortSummary(int courseId)`.
3. Implement `CohortStatsService.getStudentProgress(int learnerId)` for student self-view.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/services/cohort_stats_service.dart`
- `education_saas_server/test/unit/cohort_stats_service_test.dart`

#### ✅ Acceptance Criteria
- [ ] Accurate computation of cohort and individual metrics.
- [ ] Clean-first-try count correctly derived.

> ⚠️ **Gotchas & References:** Combines precomputed Question counters with learner attempt metrics for fast dashboard rendering.

---

### `T-021` - QuestionAdminService (Teacher Topic Notes & Hints)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 1.0 hours
- **Depends On:** T-018
- **User Stories:** US-160, US-162

> **Goal:** Teacher service to edit topic notes and hints with validation (trim, max 2000 chars, empty -> null).

#### 🧪 Tests First (TDD Specification)
- [ ] `test('updateTopicNote trims text and updates question')`
- [ ] `test('updateTopicNote with empty string sets topicNote to null')`
- [ ] `test('updateTopicNote throws validation error if text exceeds 2000 chars')`

#### 🛠️ Implementation Steps
1. Write unit tests.
2. Implement `QuestionAdminService`.
3. Validate length bounds and sanitization.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/services/question_admin_service.dart`
- `education_saas_server/test/unit/question_admin_service_test.dart`

#### ✅ Acceptance Criteria
- [ ] Unit tests pass.
- [ ] Note updates are validated.

> ⚠️ **Gotchas & References:** Ensures notes don't exceed reasonable mobile payload sizes.

---

### `T-022` - Authentication, Scopes & Learner Mapping

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 2.5 hours
- **Depends On:** T-018

> **Goal:** Configure Serverpod authentication, Scope definitions ('teacher', 'student'), and automatic Learner entity provisioning.

#### 🧪 Tests First (TDD Specification)
- [ ] `Integration test checking teacher user has 'teacher' scope and student has 'student' scope`
- [ ] `Test automatic Learner table record creation on first sign-in`

#### 🛠️ Implementation Steps
1. Define scopes: `AppScopes.teacher` and `AppScopes.student`.
2. Implement post-login hook creating Learner record if not present.
3. Configure JWT tokens and password secrets in Serverpod server setup.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/config/scopes.dart`
- `education_saas_server/lib/src/services/auth_provisioning_service.dart`

#### ✅ Acceptance Criteria
- [ ] Auth roles verified via Serverpod scopes.
- [ ] Every authenticated user maps to a Learner id.

> ⚠️ **Gotchas & References:** Enforces separation of concerns: teachers cannot be graded as students, students cannot access admin endpoints.

---

### `T-023` - Endpoints Layer (Thin MVC Controllers) & AppContainer

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 2.5 hours
- **Depends On:** T-019, T-020, T-021, T-022
- **User Stories:** US-160, US-161, US-162, US-163, US-164, US-165

> **Goal:** Create thin Serverpod endpoints delegating to domain services, with strict scope annotations and AppContainer DI.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `serverpod generate` to verify endpoint client stubs generate cleanly`

#### 🛠️ Implementation Steps
1. Build `AppContainer` holding singleton services, overridable in tests.
2. Implement `PracticeEndpoint extends Endpoint`: `nextCard(courseId)`, `requestHelp(questionId)`, `submitAnswer(questionId, answer)`.
3. Implement `ProgressEndpoint extends Endpoint`: `mySummary(courseId)`.
4. Implement `QuestionEndpoint extends Endpoint` (requiredScopes: [AppScopes.teacher]): `updateTopicNote`, `updateHelpHint`, `listQuestions`.
5. Implement `DashboardEndpoint extends Endpoint` (requiredScopes: [AppScopes.teacher]): `cohortSummary(courseId)`.
6. Implement `DemoClockEndpoint extends Endpoint`: `getNow()`, `advanceDays(int days)`.
7. Run `serverpod generate`.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/di/app_container.dart`
- `education_saas_server/lib/src/endpoints/practice_endpoint.dart`
- `education_saas_server/lib/src/endpoints/progress_endpoint.dart`
- `education_saas_server/lib/src/endpoints/question_endpoint.dart`
- `education_saas_server/lib/src/endpoints/dashboard_endpoint.dart`
- `education_saas_server/lib/src/endpoints/demo_clock_endpoint.dart`

#### ✅ Acceptance Criteria
- [ ] Endpoints are thin (less than 25 lines per method), delegating all logic to services.
- [ ] Client stubs regenerate automatically.

> ⚠️ **Gotchas & References:** Thin endpoint controller pattern keeps Serverpod layer purely responsible for auth checks and serialization.

---

### `T-024` - Serverpod Integration Tests (`withServerpod`)

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 3.0 hours
- **Depends On:** T-023
- **User Stories:** US-160, US-161, US-162, US-163, US-168

> **Goal:** End-to-end integration tests using `withServerpod` verifying full practice cycle, scope rejection, and no secret leakage.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('Full practice loop: student requests next -> requests help -> submits -> gets note -> checks counters')`
- [ ] `test('Unauthorized student cannot invoke QuestionEndpoint or DashboardEndpoint')`
- [ ] `test('PracticeItem DTO payload does not leak accepted answer or topic note')`

#### 🛠️ Implementation Steps
1. Write `practice_flow_test.dart` using Serverpod test tools.
2. Verify rollbacks between test runs.
3. Assert that `PracticeItem.question` has no answer string.
4. Assert topic note is returned in `submitAnswer` result.

#### 📁 Files to Create / Modify
- `education_saas_server/test/integration/practice_flow_test.dart`
- `education_saas_server/test/integration/security_leak_test.dart`

#### ✅ Acceptance Criteria
- [ ] Integration tests run with `dart test` and pass against local test DB.

> ⚠️ **Gotchas & References:** Serverpod 4.0 provides `withServerpod` test harness which spins up a real server and DB rolled back after each test.

---

### `T-025` - Concurrency & Invariant Verification Test

- **Track:** Serverpod (Backend)
- **Priority:** P1 - Core
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 1.5 hours
- **Depends On:** T-024
- **User Stories:** US-163

> **Goal:** Verify Question atomic counters match actual Attempt rows under concurrent requests.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('10 concurrent student submissions correctly increment attemptCount by 10 without race condition loss')`

#### 🛠️ Implementation Steps
1. Spawn 10 parallel asynchronous submissions to the same question.
2. Wait with `Future.wait`.
3. Query `question.attemptCount` and verify it exactly equals `SELECT COUNT(*) FROM attempt WHERE questionId = id`.

#### 📁 Files to Create / Modify
- `education_saas_server/test/integration/concurrency_test.dart`

#### ✅ Acceptance Criteria
- [ ] Zero counter drift under concurrent load.

> ⚠️ **Gotchas & References:** Proves the raw SQL atomic increment strategy handles concurrency without row-lock degradation.

---

### `T-026` - Seed Script & Demo Cohort Generator

- **Track:** Serverpod (Backend)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 2.0 hours
- **Depends On:** T-023

> **Goal:** CLI seed script populating 1 teacher, 5 students, 1 course, 10 questions (both Multiple Choice with option explanations and Text Input), and initial attempts with realistic chromatic distribution.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `dart run bin/seed.dart` and verify records populated in DB`

#### 🛠️ Implementation Steps
1. Create teacher account (`teacher@ironman.test` / `Password123!`).
2. Create 5 student accounts (`student1@ironman.test` .. `student5@ironman.test`).
3. Create course 'STEM Math Mastery'.
4. Create 10 questions across 3 topics ('Algebra', 'Geometry', 'Fractions') with rich `topicNote` and `helpHint` values.
5. Generate sample attempts so the teacher dashboard shows realistic charts immediately upon launch.
6. Seed MCQ questions with 4 options each, containing detailed explanation notes for why correct and distractor choices are right/wrong.

#### 📁 Files to Create / Modify
- `education_saas_server/bin/seed.dart`

#### ✅ Acceptance Criteria
- [ ] Script runs idempotently.
- [ ] Database is demo-ready.

> ⚠️ **Gotchas & References:** Vital for hackathon judges to immediately see populated charts and metrics without manual data entry.

---

### `T-030` - ErrorReporter Abstraction & Serverpod Sentry Integration

- **Track:** Monitoring
- **Priority:** P0 - Blocker
- **Scheduled:** Day 3 (Oct 10)
- **Estimate:** 1.5 hours
- **Depends On:** T-005
- **User Stories:** US-167

> **Goal:** Implement ErrorReporter abstraction and wire Serverpod diagnostic event handler to capture unhandled server exceptions into Sentry while filtering expected 4xx/validation errors.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('FakeErrorReporter records captured exception in unit tests')`
- [ ] `test('Sentry handler filters out DomainException and validation errors, only reporting unexpected errors')`

#### 🛠️ Implementation Steps
1. Define `ErrorReporter` interface (`captureException(dynamic e, StackTrace? st, {Map<String, dynamic>? extra})`).
2. Implement `SentryErrorReporter` and `FakeErrorReporter`.
3. In `server.dart`, configure Serverpod diagnostic handler: `experimentalFeatures: ExperimentalFeatures(diagnosticEventHandlers: [sentryDiagnosticHandler])`.
4. Read Sentry DSN from `config/passwords.yaml`.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/monitoring/error_reporter.dart`
- `education_saas_server/lib/src/monitoring/sentry_server_handler.dart`
- `education_saas_server/lib/src/server.dart`

#### ✅ Acceptance Criteria
- [ ] Unhandled server errors forwarded to Sentry.
- [ ] Domain exceptions (expected business flows) are ignored.

> ⚠️ **Gotchas & References:** Diagnostic event handlers in Serverpod are observe-only and non-blocking.

---

### `T-031` - Flutter Sentry Setup & Sensitive Data Scrubbing

- **Track:** Monitoring
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 1.5 hours
- **Depends On:** T-005
- **User Stories:** US-167

> **Goal:** Initialize `sentry_flutter` in Flutter app with navigator observer and PII/answer scrubbing in `beforeSend`.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit test verifying beforeSend callback scrubs student text inputs and passwords`

#### 🛠️ Implementation Steps
1. Configure `SentryFlutter.init` in `main.dart` wrapping `runApp`.
2. Add `SentryNavigatorObserver` to router observer list.
3. Implement `beforeSend` callback: strip user typed answers, emails, passwords from breadcrumbs and event data.
4. Support disabling Sentry when DSN is empty or running in test mode.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/core/monitoring/sentry_config.dart`
- `education_saas_flutter/lib/main.dart`

#### ✅ Acceptance Criteria
- [ ] Flutter app boots inside Sentry zone.
- [ ] Zero PII or raw answer texts leaked to Sentry.

> ⚠️ **Gotchas & References:** Pass DSN via `--dart-define=SENTRY_DSN=...` so secrets are never committed.

---

### `T-032` - Diagnostic Error Simulation Endpoint & Debug UI

- **Track:** Monitoring
- **Priority:** P1 - Core
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 1.0 hours
- **Depends On:** T-030, T-031
- **User Stories:** US-167

> **Goal:** Add a controlled crash trigger (server endpoint and hidden debug button) to demonstrate live Sentry error capture during hackathon evaluation.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('Debug crash endpoint throws simulated server exception')`

#### 🛠️ Implementation Steps
1. Create `DebugEndpoint.triggerServerCrash()` (guarded by kDebugMode or teacher role).
2. Add 'Test Sentry' button in Settings/Debug screen in Flutter.
3. Verify both server and client test errors land in Sentry dashboard with stacktraces.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/endpoints/debug_endpoint.dart`
- `education_saas_flutter/lib/ui/settings/debug_crash_button.dart`

#### ✅ Acceptance Criteria
- [ ] Demonstrable error telemetry in live Sentry dashboard for judges.

> ⚠️ **Gotchas & References:** Crucial proof for the judging team that error tracking actually works.

---

### `T-040` - Flutter App Shell, Dependency Injection & Routing

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 2.0 hours
- **Depends On:** T-005

> **Goal:** Setup clean Flutter directory layout, Provider-based dependency injection, and GoRouter routes.

#### 🧪 Tests First (TDD Specification)
- [ ] `Widget test verifying app boots and renders initial route without crashing`

#### 🛠️ Implementation Steps
1. Establish directory structure: `core/`, `data/`, `ui/`, `l10n/`.
2. Configure DI container providing Serverpod Client, Repositories, ViewModels.
3. Configure GoRouter routes: `/login`, `/practice`, `/dashboard`, `/teacher-notes`.
4. Setup modern Material 3 theme.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/core/di/locator.dart`
- `education_saas_flutter/lib/core/routing/app_router.dart`
- `education_saas_flutter/lib/core/theme/app_theme.dart`
- `education_saas_flutter/lib/app.dart`

#### ✅ Acceptance Criteria
- [ ] Clean compilation and navigation.

> ⚠️ **Gotchas & References:** Strictly separate UI from data layers following the official Flutter architecture guide.

---

### `T-041` - MVVM Base Infrastructure: `Command` & `Result` Types

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 1.0 hours
- **Depends On:** T-040

> **Goal:** Implement Command pattern and functional Result type for robust MVVM state management without external bloc boilerplate.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('Command sets running true while executing and false on complete')`
- [ ] `test('Command catches exception and populates error field without unhandled crash')`
- [ ] `test('Result.ok and Result.error handle success and failure flows safely')`

#### 🛠️ Implementation Steps
1. Write `test/unit/command_test.dart`.
2. Implement `Command0` (no args) and `Command1<T>` (single arg) with `ChangeNotifier`.
3. Implement `Result<T>` sealed class (`Ok<T>`, `Error<T>`).

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/core/mvvm/command.dart`
- `education_saas_flutter/lib/core/mvvm/result.dart`
- `education_saas_flutter/test/unit/command_test.dart`

#### ✅ Acceptance Criteria
- [ ] 100% test coverage on Command and Result classes.

> ⚠️ **Gotchas & References:** The Command pattern is Google's recommended approach for MVVM in Flutter, binding action states directly to UI buttons.

---

### `T-042` - Flutter Data Layer: Repositories & Serverpod Client Wrapper

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 2.5 hours
- **Depends On:** T-041
- **User Stories:** US-160, US-162, US-163

> **Goal:** Implement Flutter repository interfaces wrapping Serverpod client calls into Result types.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit test verifying repository maps Serverpod client exceptions into Result.error`

#### 🛠️ Implementation Steps
1. Implement `PracticeRepository` (`nextCard`, `requestHelp`, `submit`).
2. Implement `DashboardRepository` (`cohortSummary`).
3. Implement `QuestionRepository` (`listQuestions`, `updateTopicNote`, `updateHelpHint`).
4. Implement `AuthRepository` (`signIn`, `signOut`, `currentUser`).

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/data/repositories/practice_repository.dart`
- `education_saas_flutter/lib/data/repositories/dashboard_repository.dart`
- `education_saas_flutter/lib/data/repositories/question_repository.dart`
- `education_saas_flutter/lib/data/repositories/auth_repository.dart`

#### ✅ Acceptance Criteria
- [ ] Repositories hide Serverpod network details from ViewModels.

> ⚠️ **Gotchas & References:** ViewModels only consume repository interfaces, enabling frictionless mocktail testing.

---

### `T-043` - `easy_localization` Setup, JSON Dictionaries & Codegen

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 2.0 hours
- **Depends On:** T-005
- **User Stories:** US-166

> **Goal:** Configure easy_localization with English and Arabic JSON files, generate LocaleKeys class, and support RTL layout switching.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `dart run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart``
- [ ] `Unit test verifying en.json and ar.json contain identical keys`

#### 🛠️ Implementation Steps
1. Add `assets/translations/` to pubspec.yaml assets.
2. Create comprehensive `en.json` covering all UI labels, buttons, errors, and pluralizations ('{} days').
3. Create fluent Arabic `ar.json` covering all identical keys.
4. Generate `LocaleKeys` class via CLI.
5. Initialize `EasyLocalization` in `main.dart` with locales: `[Locale('en'), Locale('ar')]`, fallback `Locale('en')`.
6. Build language selector widget.

#### 📁 Files to Create / Modify
- `education_saas_flutter/assets/translations/en.json`
- `education_saas_flutter/assets/translations/ar.json`
- `education_saas_flutter/lib/l10n/locale_keys.g.dart`
- `education_saas_flutter/lib/ui/widgets/language_selector.dart`

#### ✅ Acceptance Criteria
- [ ] Zero compilation errors on `LocaleKeys`.
- [ ] Switching locale in app flips layout direction between LTR and RTL smoothly.

> ⚠️ **Gotchas & References:** User mandate: App MUST depend on easy_localization, no static/hardcoded texts.

---

### `T-044` - Hardcoded String Guard Unit Test

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 1.0 hours
- **Depends On:** T-043
- **User Stories:** US-166

> **Goal:** Automated AST/regex lint unit test scanning `lib/ui/` to guarantee NO hardcoded text literals exist in Text widgets.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `flutter test test/lint/no_hardcoded_strings_test.dart` and assert it flags unlocalized Text("Hello") and passes on Text(LocaleKeys.hello.tr())`

#### 🛠️ Implementation Steps
1. Write Dart test that walks all `.dart` files under `lib/ui/`.
2. Detect `Text('...')` or `Text("...")` where the argument is a literal string not calling `.tr()`.
3. Whitelist icons, keys, and teacher-authored dynamic strings.
4. Fail build if hardcoded UI string is introduced.

#### 📁 Files to Create / Modify
- `education_saas_flutter/test/lint/no_hardcoded_strings_test.dart`

#### ✅ Acceptance Criteria
- [ ] Test passes on valid localized code and fails if developer introduces hardcoded text.

> ⚠️ **Gotchas & References:** Enforces 100% compliance with the user requirement to never use static strings.

---

### `T-045` - AuthViewModel & Login/Register Screen

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 2.5 hours
- **Depends On:** T-042, T-043

> **Goal:** Build MVVM Login/Register view with quick-login buttons for Demo Teacher and Demo Students.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('AuthViewModel.signIn updates running state and navigates on success')`
- [ ] `test('AuthViewModel.signIn exposes error message when credentials invalid')`

#### 🛠️ Implementation Steps
1. Write `auth_view_model_test.dart` with mocktail repo.
2. Implement `AuthViewModel` with `signInCommand`.
3. Build `LoginView` using `LocaleKeys`.
4. Add convenient 'Quick Demo Login' chips (Teacher, Student 1, Student 2) for hackathon demo speed.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/auth/auth_view_model.dart`
- `education_saas_flutter/lib/ui/auth/login_view.dart`
- `education_saas_flutter/test/viewmodels/auth_view_model_test.dart`

#### ✅ Acceptance Criteria
- [ ] Login works via email/password and demo shortcuts.
- [ ] All strings use `.tr()`.

> ⚠️ **Gotchas & References:** Demo chips save precious time during live judging and screen recordings.

---

### `T-046` - PracticeViewModel (TDD with Mocktail)

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 4 (Oct 11)
- **Estimate:** 3.0 hours
- **Depends On:** T-042
- **User Stories:** US-160, US-161, US-162

> **Goal:** MVVM PracticeViewModel managing MCQ option selection (`selectOption`), text typing, submission, ReflexTier chromatic feedback, option explanations, and topic note gate.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('loadNext emits PracticeUiState.questionShown')`
- [ ] `test('loadNext emits PracticeUiState.deckComplete when server returns null')`
- [ ] `test('requestHelp calls repo and reveals hint without submitting')`
- [ ] `test('submitAnswer emits PracticeUiState.resultShown with topicNote and noteAcknowledged=false')`
- [ ] `test('acknowledgeNote sets noteAcknowledged=true, allowing navigation to next card')`
- [ ] `test('loadNext is rejected if topic note was shown but not acknowledged')`
- [ ] `test('selectOption(id) updates selectedOptionId in state')`
- [ ] `test('submitAnswer updates state to ResultShown with ReflexTier and optionExplanations')`

#### 🛠️ Implementation Steps
1. Write `practice_view_model_test.dart` covering state transitions.
2. Define sealed `PracticeUiState` (`Loading`, `QuestionShown`, `ResultShown`, `DeckComplete`, `Failure`).
3. Implement `PracticeViewModel` with `loadNextCommand`, `requestHelpCommand`, `submitCommand`, and `acknowledgeNote()` method.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/practice/practice_view_model.dart`
- `education_saas_flutter/lib/ui/practice/practice_state.dart`
- `education_saas_flutter/test/viewmodels/practice_view_model_test.dart`

#### ✅ Acceptance Criteria
- [ ] 100% test coverage on PracticeViewModel.
- [ ] Topic note gate enforced in state.

> ⚠️ **Gotchas & References:** The gate prevents calling `loadNext` until `acknowledgeNote()` has been invoked by the student.

---

### `T-047` - Practice Screen & Widgets (Question Card, Multiple Choice, Chromatic Aura, Note Gate)

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 4.0 hours
- **Depends On:** T-046, T-043
- **User Stories:** US-160, US-161, US-162

> **Goal:** Build student practice screen with MultipleChoiceWidget, animated response timer, Chromatic Aura (Red/Yellow/Green card background), option explanations ('Why this choice is right/wrong'), and mandatory Topic Note Gate.

#### 🧪 Tests First (TDD Specification)
- [ ] `Widget test verifying TopicNoteGateWidget disables Continue button until student taps 'I have read the note'`
- [ ] `Widget test verifying Help button triggers HelpBottomSheet`

#### 🛠️ Implementation Steps
1. Build `PracticeView` consuming `PracticeViewModel`.
2. Build `MultipleChoiceWidget`: renders selectable option cards with active hover/tap state.
3. Build `ResponseTimerWidget` with animated countdown cue.
4. Build `ChromaticFeedbackContainer`: animates background to Green (`#E8F5E9`), Yellow (`#FFFBEB`), or Red (`#FEF2F2`) on submission.
5. Build `OptionExplanationWidget`: shows selected choice explanation note ('Why this choice was right/wrong') and highlights the correct choice.
6. Integrate `TopicNoteGateWidget`: displays `topicNote` with 'I have read the explanation and note' acknowledgment button that unlocks 'Continue'.
7. Build `DeckCompleteWidget`.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/practice/practice_view.dart`
- `education_saas_flutter/lib/ui/practice/widgets/question_card_widget.dart`
- `education_saas_flutter/lib/ui/practice/widgets/response_timer_widget.dart`
- `education_saas_flutter/lib/ui/practice/widgets/help_bottom_sheet.dart`
- `education_saas_flutter/lib/ui/practice/widgets/result_feedback_sheet.dart`
- `education_saas_flutter/lib/ui/practice/widgets/topic_note_gate_widget.dart`
- `education_saas_flutter/lib/ui/practice/widgets/deck_complete_widget.dart`
- `reflex_flutter/lib/ui/practice/widgets/multiple_choice_widget.dart`
- `reflex_flutter/lib/ui/practice/widgets/option_explanation_widget.dart`

#### ✅ Acceptance Criteria
- [ ] All UI components localized via `LocaleKeys`.
- [ ] Continue button remains strictly disabled until note is acknowledged.
- [ ] Topic note is shown after submission for both correct and wrong answers.

> ⚠️ **Gotchas & References:** Fulfills the user requirement: teacher note must be read and acknowledged before proceeding to the next card.

---

### `T-048` - Practice Screen Widget Tests (TDD)

- **Track:** Flutter (Client)
- **Priority:** P1 - Core
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 2.0 hours
- **Depends On:** T-047
- **User Stories:** US-161, US-162, US-166, US-168

> **Goal:** Widget tests validating Note Gate interaction, Help Hint display, and Arabic RTL layout flipping.

#### 🧪 Tests First (TDD Specification)
- [ ] `testWidgets('Continue button is disabled when topic note is present and unacknowledged')`
- [ ] `testWidgets('Tapping acknowledge enables Continue button and advances card')`
- [ ] `testWidgets('Arabic locale renders RTL text alignment')`

#### 🛠️ Implementation Steps
1. Write widget tests with mocktail ViewModel.
2. Pump `TopicNoteGateWidget` and test tap interaction.
3. Test RTL text rendering under `Locale('ar')`.

#### 📁 Files to Create / Modify
- `education_saas_flutter/test/widgets/practice_view_test.dart`
- `education_saas_flutter/test/widgets/topic_note_gate_test.dart`

#### ✅ Acceptance Criteria
- [ ] Widget tests pass in headless environment.

> ⚠️ **Gotchas & References:** Verifies UI requirements programmatically without requiring manual clicks.

---

### `T-049` - Student Self-Progress Card & Profile Screen

- **Track:** Flutter (Client)
- **Priority:** P1 - Core
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 1.5 hours
- **Depends On:** T-042, T-043
- **User Stories:** US-164, US-165

> **Goal:** Student screen showing their own metrics: clean-first-try solves, cards mastered, and current study streak.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit test for StudentProgressViewModel verifying metric formatting`

#### 🛠️ Implementation Steps
1. Implement `StudentProgressViewModel` calling `progressRepo.mySummary()`.
2. Build `StudentProgressView` with Clean Solves metric badge, average latency, and mastery progress.
3. Localize all strings.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/progress/student_progress_view.dart`
- `education_saas_flutter/lib/ui/progress/student_progress_view_model.dart`

#### ✅ Acceptance Criteria
- [ ] Students can view their clean-first-try count and mastery progress.

> ⚠️ **Gotchas & References:** Empowers students to track their own mastery directly.

---

### `T-050` - Teacher Topic Note, Option & Hint Editor Screen

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 3.0 hours
- **Depends On:** T-042, T-043
- **User Stories:** US-160, US-162

> **Goal:** Teacher screen allowing inline browsing of questions, editing multiple-choice options with explanations (why right/wrong), and updating topic notes and hints.

#### 🧪 Tests First (TDD Specification)
- [ ] `test('saveNote updates question in repo and shows success feedback')`
- [ ] `test('saveHint updates hint in repo')`

#### 🛠️ Implementation Steps
1. Write `teacher_notes_view_model_test.dart`.
2. Implement `TeacherNotesViewModel`.
3. Build `TeacherNotesView` listing course questions with expansion tiles.
4. Add text fields for Topic Note and Help Hint with character counter (max 2000) and Save button.
5. Localize all labels via `LocaleKeys`.
6. Add option editor UI: teacher can add/remove options, toggle `isCorrect`, and edit the explanation note per option.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/teacher_notes/teacher_notes_view.dart`
- `education_saas_flutter/lib/ui/teacher_notes/teacher_notes_view_model.dart`
- `education_saas_flutter/test/viewmodels/teacher_notes_view_model_test.dart`

#### ✅ Acceptance Criteria
- [ ] Teacher can edit and save topic notes and hints for any question.
- [ ] Changes immediately reflect when student practices that question.

> ⚠️ **Gotchas & References:** Fulfills the user requirement: teacher can add a note for the question showing more information about the topic.

---

### `T-051` - Teacher Analytics Dashboard (Cohort Mastery, Question Insights, Student Table)

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 4.0 hours
- **Depends On:** T-042, T-043
- **User Stories:** US-163, US-164

> **Goal:** Build comprehensive teacher dashboard displaying Topic Mastery bars, Question Insights Table (all 6 counters), and Student Table (clean-first-try counts).

#### 🧪 Tests First (TDD Specification)
- [ ] `test('DashboardViewModel loads cohort summary and maps question insights correctly')`

#### 🛠️ Implementation Steps
1. Write ViewModel unit tests.
2. Implement `DashboardViewModel` with auto-refresh and manual refresh command.
3. Build `TopicMasteryBars` showing mastery percentage per topic.
4. Build `QuestionInsightsTable` displaying: Prompt, Topic, Total Attempts, Solved Students, First-Try Solves, Under-Time Solves, Clean Solves, and First-Try Rate %.
5. Build `StudentCohortTable` displaying: Student Name, Cards Mastered, Clean-First-Try Solves, Avg Latency.
6. Full localization with `LocaleKeys`.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/dashboard/dashboard_view.dart`
- `education_saas_flutter/lib/ui/dashboard/dashboard_view_model.dart`
- `education_saas_flutter/lib/ui/dashboard/widgets/topic_mastery_bars.dart`
- `education_saas_flutter/lib/ui/dashboard/widgets/question_insights_table.dart`
- `education_saas_flutter/lib/ui/dashboard/widgets/student_cohort_table.dart`
- `education_saas_flutter/test/viewmodels/dashboard_view_model_test.dart`

#### ✅ Acceptance Criteria
- [ ] Question insights table renders all 6 Question counters requested by user.
- [ ] Student table shows clean-first-try count per student.
- [ ] Completely localized with Arabic RTL support.

> ⚠️ **Gotchas & References:** This is the primary showcase view for hackathon judges proving that learning analytics work.

---

### `T-052` - Demo Clock Control Widget

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 1.0 hours
- **Depends On:** T-040, T-043

> **Goal:** Convenient floating/drawer toolbar allowing judges/evaluators to advance time by +1 day, +7 days, +30 days with a single tap.

#### 🧪 Tests First (TDD Specification)
- [ ] `Widget test verifying tapping +1 Day calls demo clock endpoint`

#### 🛠️ Implementation Steps
1. Create `DemoClockControllerWidget` visible in debug and demo mode.
2. Display current simulated date.
3. Add action chips: '+1 Day (test wrong/help card)', '+2 Days (test slow card)', '+30 Days (test clean card)'.
4. On click, invoke `DemoClockEndpoint.advanceDays(...)` and trigger current view refresh.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/ui/widgets/demo_clock_controller_widget.dart`

#### ✅ Acceptance Criteria
- [ ] Time shifts cleanly in app without restarting backend.

> ⚠️ **Gotchas & References:** Essential for live video demo to show spaced repetition intervals without waiting days.

---

### `T-053` - Arabic Localization & RTL Visual Polish

- **Track:** Flutter (Client)
- **Priority:** P0 - Blocker
- **Scheduled:** Day 5 (Oct 12)
- **Estimate:** 1.5 hours
- **Depends On:** T-043, T-047, T-050, T-051
- **User Stories:** US-166

> **Goal:** Review every screen under Arabic locale, verify RTL padding, text alignment, and number formatting.

#### 🧪 Tests First (TDD Specification)
- [ ] `Run app in Arabic and verify no overflow errors or broken alignments`

#### 🛠️ Implementation Steps
1. Verify all card layouts, icons (e.g., arrow directions), and tables under RTL.
2. Format dates and numbers using `intl` / `easy_localization`.
3. Verify that teacher-created question prompts and notes render correctly in both LTR and RTL.

#### 📁 Files to Create / Modify
- `education_saas_flutter/assets/translations/ar.json`

#### ✅ Acceptance Criteria
- [ ] Flawless Arabic presentation across all screens.
- [ ] Zero text truncation or overflow.

> ⚠️ **Gotchas & References:** Key differentiator for Africa regional suitability.

---

### `T-060` - Backend Deployment (Serverpod Cloud / Railway / Docker)

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 6 (Oct 13)
- **Estimate:** 3.0 hours
- **Depends On:** T-023, T-026

> **Goal:** Deploy the Serverpod backend and PostgreSQL to a live cloud host (Serverpod Cloud or Railway/Render/fly.io) with valid SSL.

#### 🧪 Tests First (TDD Specification)
- [ ] `Curl production `/` or health check and receive HTTP 200`

#### 🛠️ Implementation Steps
1. Try `serverpod cloud launch` if access is provisioned.
2. Otherwise, deploy containerized Serverpod app to Railway/Render with managed Postgres.
3. Run migrations and seed command on remote DB.
4. Verify production endpoint URL is accessible over HTTPS.

#### 📁 Files to Create / Modify
- `education_saas_server/Dockerfile`
- `docker-compose.prod.yaml`

#### ✅ Acceptance Criteria
- [ ] Live backend running on public HTTPS URL.
- [ ] Judges can connect without running Docker locally.

> ⚠️ **Gotchas & References:** 55% of judging score requires 'does it work' and live Serverpod stack.

---

### `T-061` - Flutter Web / Android APK Production Build

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 6 (Oct 13)
- **Estimate:** 2.0 hours
- **Depends On:** T-060

> **Goal:** Build Flutter Web release (hosted via GitHub Pages or Firebase Hosting) and Android APK pointing to live backend.

#### 🧪 Tests First (TDD Specification)
- [ ] `Build with `flutter build web --release` and `flutter build apk --release``

#### 🛠️ Implementation Steps
1. Configure environment config to use production backend URL by default.
2. Build web release: `flutter build web --release`.
3. Deploy web build to Firebase Hosting or GitHub Pages.
4. Build release APK: `flutter build apk --release`.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/core/config/env.dart`

#### ✅ Acceptance Criteria
- [ ] Working public web link for immediate judge testing.
- [ ] Downloadable APK artifact provided in GitHub release.

> ⚠️ **Gotchas & References:** Web app allows judges to test instantly on desktop or mobile browsers without installing an APK.

---

### `T-062` - Automated End-to-End Smoke Test Script

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 6 (Oct 13)
- **Estimate:** 1.5 hours
- **Depends On:** T-060
- **User Stories:** US-168

> **Goal:** Command-line Dart script exercising full flow against live deployment (login -> seed -> practice -> help -> note gate -> submit -> advance clock -> dashboard).

#### 🧪 Tests First (TDD Specification)
- [ ] `Run `dart run tool/smoke_test.dart https://api.yourdomain.com` and ensure 0 exit code`

#### 🛠️ Implementation Steps
1. Script connects via generated Serverpod client.
2. Authenticates as teacher, seeds/checks questions.
3. Authenticates as student, requests card, requests help, submits answer, verifies topic note is returned.
4. Verifies Question counters incremented.
5. Advances demo clock by 1 day.
6. Authenticates as teacher and queries dashboard summary.

#### 📁 Files to Create / Modify
- `tool/smoke_test.dart`

#### ✅ Acceptance Criteria
- [ ] Smoke script passes 100% on production URL.

> ⚠️ **Gotchas & References:** Can be executed before video recording to ensure zero surprises.

---

### `T-063` - Project Documentation, ARCHITECTURE.md & README.md

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 6 (Oct 13)
- **Estimate:** 1.5 hours
- **Depends On:** T-004

> **Goal:** Write comprehensive README.md and ARCHITECTURE.md highlighting architectural choices, judging checklist, and Africa mission.

#### 🧪 Tests First (TDD Specification)
- [ ] `Verify all links, badges, and code snippets render cleanly`

#### 🛠️ Implementation Steps
1. Document architecture: Flutter MVVM, Serverpod Controller-Service-Repository, Sentry error monitoring, easy_localization, TDD pyramid.
2. Detail the 6 Question counters and clean-first-try metric.
3. Explain the post-submission topic note gate and help interval rules.
4. Provide demo credentials (`teacher@ironman.test`, `student1@ironman.test`).
5. Include live URLs (web app, backend API, Sentry dashboard screenshot).

#### 📁 Files to Create / Modify
- `README.md`
- `ARCHITECTURE.md`

#### ✅ Acceptance Criteria
- [ ] Professional, publication-grade README tailored for hackathon judges.

> ⚠️ **Gotchas & References:** Judges read README first. A clear, well-structured guide makes an immediate positive impression.

---

### `T-064` - Final UML Diagrams Export & Verification

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 6 (Oct 13)
- **Estimate:** 1.0 hours

> **Goal:** Ensure all 14 UML diagrams are up to date and linked in docs and README.

#### 🧪 Tests First (TDD Specification)
- [ ] `Verify all 14 PNG files exist and are referenced`

#### 🛠️ Implementation Steps
1. Confirm all 14 diagrams match final implementation.
2. Include thumbnail references in repo documentation.

#### 📁 Files to Create / Modify
- `docs/competition/uml/README.md`

#### ✅ Acceptance Criteria
- [ ] All 14 diagrams present and documented.

> ⚠️ **Gotchas & References:** Visual diagrams demonstrate architectural rigor to judges.

---

### `T-065` - Demo Video Recording & Script (3-Minute Walkthrough)

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 7 (Oct 14)
- **Estimate:** 3.0 hours
- **Depends On:** T-061, T-062

> **Goal:** Record professional 3-minute screen recording demonstrating the core flow, topic note gate, help request, question insights, Sentry error tracking, and Arabic localization.

#### 🧪 Tests First (TDD Specification)
- [ ] `Rehearse demo script in under 180 seconds`

#### 🛠️ Implementation Steps
1. Write second-by-second script in `docs/DEMO_SCRIPT.md`.
2. 0:00-0:30: Problem & Mission (Africa context, spaced repetition).
3. 0:30-1:15: Student Practice (clean solve, Need Help hint, post-submission Topic Note Gate, acknowledgment).
4. 1:15-1:50: Demo Clock time advancement & interval verification (+1d, +2d, +30d).
5. 1:50-2:25: Teacher Dashboard (Topic Mastery, Question Insights with 6 counters, Student clean-first-try metrics, Arabic RTL toggle).
6. 2:25-2:45: Sentry error capture demonstration via debug button.
7. 2:45-3:00: Serverpod architecture summary & conclusion.
8. Record video, compress to MP4, upload to YouTube/Vimeo unlisted.

#### 📁 Files to Create / Modify
- `docs/DEMO_SCRIPT.md`

#### ✅ Acceptance Criteria
- [ ] High quality video under 3 minutes uploaded and linked in submission.

> ⚠️ **Gotchas & References:** Strictly stick to 3 minutes. Judges will not watch longer videos.

---

### `T-066` - Submission Tag & Checklist Verification

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 7 (Oct 14)
- **Estimate:** 1.0 hours
- **Depends On:** T-065

> **Goal:** Perform final verification against official Serverpod competition checklist and create git release tag.

#### 🧪 Tests First (TDD Specification)
- [ ] `Verify all submission form URLs (repo, video, live app) are public and working`

#### 🛠️ Implementation Steps
1. Review official hackathon rules.
2. Verify repo is public (or access granted to judges).
3. Create git tag `v1.0.0-hackathon`.
4. Submit official submission form before deadline.

#### 📁 Files to Create / Modify
- `docs/SUBMISSION.md`

#### ✅ Acceptance Criteria
- [ ] Submission submitted with confirmation.

> ⚠️ **Gotchas & References:** Submit at least 2 hours before the absolute deadline on Oct 14.

---

### `T-067` - Competition Buffer & Bug Triage

- **Track:** DevOps & Submission
- **Priority:** P0 - Blocker
- **Scheduled:** Day 7 (Oct 14)
- **Estimate:** 4.0 hours
- **Depends On:** T-066

> **Goal:** Dedicated time buffer for unexpected deployment issues, bug fixes, or minor styling tweaks.

#### 🧪 Tests First (TDD Specification)
- *(No automated tests required for setup/config task)*

#### 🛠️ Implementation Steps
1. Keep schedule open on Oct 14 for last minute adjustments.

#### 📁 Files to Create / Modify
- *(None)*

#### ✅ Acceptance Criteria
- [ ] Zero unhandled critical bugs.

> ⚠️ **Gotchas & References:** Every hackathon requires an explicit time buffer.

---

### `T-070` - French Localization (`fr.json`)

- **Track:** Stretch
- **Priority:** P2 - Stretch
- **Scheduled:** Post-P0/P1
- **Estimate:** 2.0 hours
- **Depends On:** T-043
- **User Stories:** US-166

> **Goal:** Add French translation dictionary for Francophone Africa regions.

#### 🧪 Tests First (TDD Specification)
- [ ] `Unit test verifying fr.json matches en.json keys`

#### 🛠️ Implementation Steps
1. Create `fr.json` with translations.
2. Add `Locale('fr')` to supported locales.

#### 📁 Files to Create / Modify
- `education_saas_flutter/assets/translations/fr.json`

#### ✅ Acceptance Criteria
- [ ] App runs in French.

> ⚠️ **Gotchas & References:** Only do if all P0/P1 tasks are completed early.

---

### `T-071` - Realtime Dashboard via Serverpod Streaming Methods

- **Track:** Stretch
- **Priority:** P2 - Stretch
- **Scheduled:** Post-P0/P1
- **Estimate:** 3.0 hours
- **Depends On:** T-023, T-051

> **Goal:** Stream live student submissions directly to open Teacher Dashboard via Serverpod 4.0 streaming methods.

#### 🧪 Tests First (TDD Specification)
- [ ] `Test streaming method sends event on submitAnswer`

#### 🛠️ Implementation Steps
1. Implement streaming method in DashboardEndpoint.
2. Listen to stream in DashboardViewModel to update charts in real time.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/endpoints/dashboard_endpoint.dart`

#### ✅ Acceptance Criteria
- [ ] Teacher sees question counters tick up live as student submits.

> ⚠️ **Gotchas & References:** Serverpod 4.0 uses streaming methods, replacing the older streaming endpoints API.

---

### `T-072` - DueDigest Scheduled Task via FutureCall

- **Track:** Stretch
- **Priority:** P2 - Stretch
- **Scheduled:** Post-P0/P1
- **Estimate:** 2.5 hours
- **Depends On:** T-010

> **Goal:** Serverpod FutureCall scheduled job computing upcoming due card counts per student.

#### 🧪 Tests First (TDD Specification)
- [ ] `Integration test for FutureCall execution`

#### 🛠️ Implementation Steps
1. Define FutureCall in Serverpod.
2. Schedule daily run in `server.dart`.

#### 📁 Files to Create / Modify
- `education_saas_server/lib/src/future_calls/due_digest.dart`

#### ✅ Acceptance Criteria
- [ ] Scheduled job executes without error.

> ⚠️ **Gotchas & References:** Demonstrates Serverpod FutureCall stack capability.

---

### `T-073` - Sentry Distributed Performance Tracing

- **Track:** Stretch
- **Priority:** P2 - Stretch
- **Scheduled:** Post-P0/P1
- **Estimate:** 2.0 hours
- **Depends On:** T-030, T-031
- **User Stories:** US-167

> **Goal:** Measure transaction latency from Flutter practice screen through Serverpod database and back.

#### 🧪 Tests First (TDD Specification)
- [ ] `Verify Sentry spans emitted during practice submission`

#### 🛠️ Implementation Steps
1. Wrap submission with `Sentry.startTransaction`.
2. Propagate trace headers to Serverpod.

#### 📁 Files to Create / Modify
- `education_saas_flutter/lib/core/monitoring/tracing.dart`

#### ✅ Acceptance Criteria
- [ ] Distributed trace visible in Sentry performance tab.

> ⚠️ **Gotchas & References:** Pure stretch feature.

---
