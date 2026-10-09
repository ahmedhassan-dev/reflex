# Reflex ⚡

> **Reflex** is a high-performance, adaptive spaced-repetition learning platform built with **Serverpod** (PostgreSQL) and **Flutter**. It combines rapid-recall card drills, chromatic performance feedback, live peer statistics, and teacher-authored concept mastery explanations.

---

## 🌟 Key Features

- **Spaced-Repetition Review Queue:** Dynamically selects overdue flashcards or prioritizes new unattempted questions based on forgetting curve intervals.
- **Chromatic Feedback Aura:** Instant feedback reflecting the student's mastery level:
  - 🟢 **Green (Mastered):** Clean first-try solve answered under the target response time.
  - 🟡 **Yellow (Developing):** Correct answer, but slow response time or hint was requested.
  - 🔴 **Red (Needs Work):** Incorrect answer, scheduling the card for review in +1 day.
- **Compulsory Explanation Note Gate:** When answering, students must view and absorb the teacher's concept explanation note before proceeding to the next card.
- **Option-Specific Rationales (MCQ):** Detailed post-submission explanations for every multiple-choice option clarifying why it is correct or incorrect.
- **Atomic PostgreSQL Performance Counters:** Parameterized raw SQL atomic increments ensuring zero counter drift or race-condition data loss even under concurrent load.
- **Live Cohort Analytics:** Teacher dashboard delivering topic mastery breakdowns, question difficulty indices, and student progress metrics.
- **Time-Travel Demo Clock:** Allows judges and testers to advance the virtual calendar to simulate spaced repetition due dates in real time.
- **100% Localized (English & Arabic):** Full bilingual support with RTL awareness using `easy_localization`.
- **End-to-End Monitoring:** Distributed error tracking powered by Sentry on both backend and frontend.

---

## 🏗️ Monorepo Architecture

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
- **Docker** & **Docker Compose** (for PostgreSQL database).
- **Serverpod CLI** (`serverpod_cli 4.0.4`).

### 1. Start the PostgreSQL Database

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

### 3. Run the Server

```bash
cd reflex_server
dart run bin/main.dart
```

### 4. Run the Flutter Client

```bash
cd reflex_flutter
fvm flutter run -d chrome
```

---

## 🧪 Quality & Verification

Run the automated check script to execute static analysis and all unit, integration, and concurrency tests:

```bash
bash tool/check.sh
```

---

## 📄 License

Reflex is developed for educational and competition purposes.
