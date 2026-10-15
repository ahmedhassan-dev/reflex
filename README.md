# Reflex ⚡

> **Reflex** is a high-performance, adaptive spaced-repetition learning platform built with **Serverpod** (PostgreSQL) and **Flutter**. It combines rapid-recall card drills, chromatic performance feedback, live peer statistics, and teacher-authored concept mastery explanations.

<p align="center">
  <a href="https://www.youtube.com/watch?v=Uv20QjTRHCo" target="_blank">
    <img src="https://img.shields.io/badge/YouTube-Watch_Video_Walkthrough-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="Watch Video Walkthrough" />
  </a>
  <a href="https://reflex.serverpod.space/" target="_blank">
    <img src="https://img.shields.io/badge/Live_App-reflex.serverpod.space-0284C7?style=for-the-badge&logo=flutter&logoColor=white" alt="Live Demo" />
  </a>
  <a href="https://reflex.api.serverpod.space/" target="_blank">
    <img src="https://img.shields.io/badge/Serverpod_Backend-4.0.4-EA580C?style=for-the-badge&logo=dart&logoColor=white" alt="Serverpod Backend" />
  </a>
</p>

---

## 🎥 Video Walkthrough & Demo

> **▶️ [Watch the Full Reflex Demo on YouTube](https://www.youtube.com/watch?v=Uv20QjTRHCo)** *(Answer Fast, Receive Instant Feedback, Track Speed & Accuracy)*

<p align="center">
  <a href="https://www.youtube.com/watch?v=Uv20QjTRHCo" target="_blank">
    <img src="https://img.youtube.com/vi/Uv20QjTRHCo/maxresdefault.jpg" alt="Reflex Demo Video Walkthrough" width="90%" style="border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.12);" />
  </a>
</p>

---

## ☁️ Live Demo & Deployment

Reflex is deployed and running live on **Serverpod Cloud**:

| Service | Public URL | Description |
| :--- | :--- | :--- |
| 🎥 **Demo Video** | [https://www.youtube.com/watch?v=Uv20QjTRHCo](https://www.youtube.com/watch?v=Uv20QjTRHCo) | Complete product & architecture walkthrough |
| 🌐 **Live Web App** | [https://reflex.serverpod.space/](https://reflex.serverpod.space/) | Deployed Flutter Web client |
| ⚡ **API Server** | [https://reflex.api.serverpod.space/](https://reflex.api.serverpod.space/) | Live Serverpod backend API |
| 📊 **Serverpod Insights** | [https://reflex.insights.serverpod.space/](https://reflex.insights.serverpod.space/) | Serverpod Insights dashboard |

## 🔑 Test Credentials

Use these pre-configured accounts to explore the live app directly against the production backend:

| Role | Email | Password | What to explore |
| :--- | :--- | :--- | :--- |
| 👩‍🏫 **Teacher** | `ah3656056@gmail.com` | `12345678` | Course admin, question editor, subscription manager, cohort analytics |
| 🎓 **Student** | `ahmedhassan.op9@gmail.com` | `12345678` | Speed-recall drills, chromatic feedback, compulsory concept notes, study streaks |

> 💡 **Quick Start:** On the role selection screen, pick **Teacher** or **Student** to match your chosen persona, then sign in with the credentials above (or tap any of the demo persona buttons on the auth screen).

---

## 📱 App Tour & Mobile Screenshots

Reflex is designed mobile-first with high-fidelity dark aesthetics, micro-animations, and instant chromatic feedback.

### 🎓 1. Onboarding & Authentication

| Role Selection | Authentication (with Show Password) | Quick Demo Personas |
| :---: | :---: | :---: |
| <img src="docs/screenshots/01_role_selection.png" width="220" alt="Role Selection" /> | <img src="docs/screenshots/02_auth_signin.png" width="220" alt="Sign In iOS" /> | <img src="docs/screenshots/03_quick_demo_personas.png" width="220" alt="Quick Demo" /> |
| Student or Teacher persona switch | Email/password with visibility toggle | One-tap judge & demo logins |

### 📚 2. Student Discovery, Speed Drills & Milestones

| High School Courses Dashboard | MCQ Speed Drill (Target: 6s) | Student Progress & Streaks |
| :---: | :---: | :---: |
| <img src="docs/screenshots/04_student_courses.png" width="220" alt="High School Courses" /> | <img src="docs/screenshots/06_practice_mcq.png" width="220" alt="Physics MCQ" /> | <img src="docs/screenshots/05_student_progress.png" width="220" alt="Student Progress" /> |
| Physics, Chemistry & topic chips | Dynamic response timer vs teacher target | Mastery milestones & study streaks |

### 🎨 3. Chromatic Feedback Engine & Pedagogical Tiers

Reflex dynamically evaluates both **accuracy** and **reaction latency** against the teacher's target time to assign distinct chromatic tiers:

| 🟡 Yellow (Developing Tier) | 🔴 Red (Needs Work Tier) |
| :---: | :---: |
| <img src="docs/screenshots/07_chromatic_feedback_developing.png" width="230" alt="Yellow Developing" /> | <img src="docs/screenshots/08_chromatic_feedback_needs_work.png" width="230" alt="Red Needs Work" /> |
| **Correct, but slow or hint requested**<br>Compulsory concept note gate & full option rationales | **Inaccurate attempt**<br>Concept reinforcement & scheduled for next-day review queue |

### 📊 4. Teacher Analytics Dashboard & Question Admin

| Teacher Analytics Dashboard | Curriculum & Question Admin |
| :---: | :---: |
| <img src="docs/screenshots/09_teacher_topic_mastery.png" width="230" alt="Teacher Topic Mastery" /> | <img src="docs/screenshots/10_teacher_question_admin.png" width="230" alt="Teacher Question Admin" /> |
| Topic mastery, clean solve counts & solve rates | Topic chips, target times & question metrics |

### ✏️ 5. Teacher Question Creator & Pedagogical Authoring

| Add Question Bottom Sheet | Concept Notes & Guided Hints Editor |
| :---: | :---: |
| <img src="docs/screenshots/11_teacher_add_question_sheet.png" width="230" alt="Add Question Sheet" /> | <img src="docs/screenshots/12_teacher_concept_note_and_hints.png" width="230" alt="Concept Note and Hints Editor" /> |
| Responsive question type, points & target solve time | Foundational concept notes & hint authoring |

#### 🔄 Teacher Curriculum & Cohort Analytics Workflow

<p align="center">
  <img src="docs/diagrams/03_teacher_analytics_loop.png" alt="Teacher Curriculum & Cohort Analytics Workflow" width="100%" />
</p>

---

## 💡 Inspiration

Most educational apps are built for students who already love reading textbooks or sitting through 45-minute lectures. But many students don't: teenagers who struggle with ADHD, students in underfunded schools without access to top tutors, and kids whose attention is captured by gaming and social media.

While completing my Master's in Software Engineering at **Quantic** (a global community of over 17,000 members and alumni), I experienced how active, bite-sized smart cases transform engagement. **Reflex** brings that fast-paced active learning to the high school students who need it most.

## 🎯 What Reflex Does: The 4-Step Learning Loop

<p align="center">
  <img src="docs/diagrams/02_reflex_learning_loop.png" alt="The Reflex Learning Loop: How Active Speed-Recall Actually Works" width="100%" />
</p>

Reflex transforms studying into a fast-paced active reflex:

1. **Answer a Short Question (Active Micro-Recall):** Students solve rapid scenario cards (multiple-choice or text-input) timed against the teacher's estimated target solve time (e.g., 10s-30s) to trigger active recall without textbook burnout.
2. **Get Immediate Feedback (Chromatic Visual Aura):** Instant visual feedback (🟢 Green for mastered, 🟡 Yellow for developing, 🔴 Red for needs work) plus compulsory concept explanations and option rationales.
3. **Track Accuracy & Response Time (Hesitation Detection):** Reflex doesn't only check if an answer is right; it measures millisecond reaction latency against the teacher's target estimation to detect true mastery versus lucky guesses or hesitation.
4. **Review Again at the Right Time (Spaced Repetition Engine):** The Serverpod spaced repetition queue schedules cards at scientifically optimal intervals right before memory decays.

Teachers create courses and questions, set per-question target solve times (`expectedSeconds`), author guided hints and compulsory explanation notes, approve student subscriptions to private courses, and monitor live cohort analytics. **Each teacher only sees and manages their own content.**

## 🧠 Why Serverpod?

After years of building with Firebase, concurrency was the wall: many users writing the same shared data at the same time (a whole class submitting attempts while a teacher edits a course) leads to race conditions. Serverpod gives a typed Dart backend with **true PostgreSQL transactions**. When an answer is tapped, the server safely logs the attempt, calculates the new spaced-repetition schedule, and atomically updates counters without data conflicts. The generated client gives end-to-end type safety from database to UI.

---

## 🌟 Key Features

- **Spaced-Repetition Review Queue:** Dynamically selects overdue flashcards or prioritizes new unattempted questions based on forgetting curve intervals.
- **Chromatic Feedback Aura:** Instant feedback reflecting the student's mastery level:
  - 🟢 **Green (Mastered):** Clean first-try solve answered under the teacher's estimated target response time.
  - 🟡 **Yellow (Developing):** Correct answer, but slow response time or hint was requested.
  - 🔴 **Red (Needs Work):** Incorrect answer, scheduling the card for review in +1 day.
- **Compulsory Explanation Note Gate:** When answering, students must view and absorb the teacher's concept explanation note before proceeding to the next card.
- **Option-Specific Rationales (MCQ):** Detailed post-submission explanations for every multiple-choice option clarifying why it is correct or incorrect.
- **Atomic PostgreSQL Performance Counters:** Parameterized raw SQL atomic increments ensuring zero counter drift or race-condition data loss even under concurrent load.
- **Live Cohort Analytics:** Teacher dashboard delivering topic mastery breakdowns, question difficulty indices, and student progress metrics.
- **Teacher Content Isolation:** Every teacher can only list, edit, and view analytics for their own courses, questions, notes, and subscriptions. Ownership is enforced server-side.
- **Public & Private Courses:** Private courses require teacher approval of student subscription requests.
- **Time-Travel Demo Clock:** Allows judges and testers to advance the virtual calendar to simulate spaced repetition due dates in real time.
- **100% Localized (English & Arabic):** Full bilingual support with RTL awareness using `easy_localization`.
- **End-to-End Monitoring:** Distributed error tracking powered by Sentry on both backend and frontend.

---

## 🏗️ Monorepo Architecture

Reflex is built end-to-end in pure Dart, featuring a Flutter client (Web, iOS, Android) and a Serverpod 4.0.4 backend powered by PostgreSQL with atomic transactions and Sentry Cloud telemetry:

<p align="center">
  <img src="docs/diagrams/01_reflex_architecture.png" alt="Reflex Monorepo Architecture" width="100%" />
</p>

Reflex adopts a **Feature-First (Package-by-Feature / Screaming Architecture)** structure across both backend and frontend:

```text
reflex/
├── reflex_server/          # Serverpod 4.0 Backend (PostgreSQL ORM & Thin Endpoints)
│   ├── bin/seed.dart       # Idempotent database seeder (Course, Questions, Attempts)
│   └── lib/src/
│       ├── core/           # Clock abstraction, exceptions, Sentry error reporter, DI
│       ├── data/           # Database repositories & raw SQL atomic counter queries
│       └── features/       # Modular features: auth, practice, questions, analytics, demo_clock
│
├── reflex_client/          # Generated type-safe Dart client and protocol DTOs
│
├── reflex_flutter/         # Flutter frontend (MVVM State-Controller with native setState)
│   ├── lib/
│   │   ├── core/           # Result, UseCase, design system & Material 3 themes
│   │   ├── data/           # Serverpod client wrapper & data sources
│   │   └── presentation/   # Feature-first screens, controllers, and chromatic widgets
│   └── assets/translations # en.json & ar.json translation dictionaries
│
└── tool/
    └── check.sh            # Monorepo static analysis, server tests, and flutter tests
```

---

## 🚀 Getting Started

### Prerequisites

- **FVM** (Flutter Version Management) with Flutter `3.47.6` / Dart `3.13.5`.
- **Docker** & **Docker Compose** (for local PostgreSQL database).
- **Serverpod CLI** (`serverpod_cli 4.0.4`).

### 1. Start the Local PostgreSQL Database

```bash
cd reflex_server
docker compose up --build -d
```
> The development database runs on port `8090` (configured in `config/development.yaml`).

### 2. Seed the Database

Populate demo courses, questions (MCQ with option rationales + text input), teacher, and student attempts:

```bash
cd reflex_server
dart run bin/seed.dart
```

### 3. Run the Server Locally

```bash
cd reflex_server
dart run bin/main.dart
```

---

## 📱 Running & Building the Flutter Client

### Web & Desktop

```bash
cd reflex_flutter

# Web (Chrome)
fvm flutter run -d chrome

# macOS Desktop
fvm flutter run -d macos
```

### Android (Emulator & Physical Devices)

#### Running in Development:
```bash
# Connect to local Serverpod backend via emulator (reverse port forwarding):
adb reverse tcp:8080 tcp:8080
fvm flutter run -d android

# Connect to Serverpod Cloud backend:
fvm flutter run -d android --dart-define=SERVER_URL=https://reflex.api.serverpod.space/
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
> The generated APK will be located at `reflex_flutter/build/app/outputs/flutter-apk/app-release.apk`.

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

---

## 🧪 Quality & Verification

Run the automated check script to execute static analysis and all unit, integration, and concurrency tests:

```bash
bash tool/check.sh
```

---

## 📄 License & Vision

Reflex is developed for the Serverpod Hackathon 2026 and serves as the seed for an upcoming EdTech startup transforming active speed-recall learning.
