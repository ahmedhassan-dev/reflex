# Reflex Server 🚀

The backend engine of **Reflex**, powered by **Serverpod 4.0** and **PostgreSQL**.

---

## 🏛️ Architecture: Feature-First

The server is organized by feature rather than layer, keeping business logic, data models, domain rules, and endpoint controllers highly cohesive:

```text
lib/src/
├── core/
│   ├── clock/clock.dart                  # Time abstraction (SystemClock / FakeClock)
│   ├── errors/exceptions.dart            # Sealed ReflexException hierarchy
│   ├── monitoring/error_reporter.dart    # Sentry error reporting & telemetry
│   └── di/app_container.dart             # Per-request dependency injection
│
├── data/
│   └── repositories/
│       ├── interfaces.dart               # Domain repository contracts
│       └── serverpod_repositories.dart   # Serverpod ORM & atomic raw SQL counters
│
└── features/
    ├── auth/
    │   ├── config/scopes.dart            # Role scopes: teacher, student, admin
    │   ├── services/auth_provisioning_service.dart
    │   └── endpoints/                    # Email IDP & JWT refresh
    │
    ├── practice/
    │   ├── domain/
    │   │   ├── card_selector.dart        # Queue prioritization (overdue vs unattempted)
    │   │   ├── grader.dart               # Text normalization & MCQ option evaluation
    │   │   ├── scheduling_policy.dart    # Leitner/SuperMemo forgetting curve intervals
    │   │   └── attempt_outcome.dart      # Chromatic Reflex Tier classification
    │   ├── services/practice_service.dart # Idempotency & practice loop coordinator
    │   └── endpoints/practice_endpoint.dart # Thin MVC endpoint
    │
    ├── questions/
    │   ├── services/question_admin_service.dart # Length validation & sanitization
    │   └── endpoints/question_admin_endpoint.dart # Teacher-scoped question management
    │
    ├── analytics/
    │   ├── services/cohort_stats_service.dart   # Cohort mastery & progress metrics
    │   └── endpoints/analytics_endpoint.dart    # Analytics dashboard endpoint
    │
    ├── demo_clock/
    │   ├── services/demo_clock_service.dart     # Time offset provider
    │   └── endpoints/demo_clock_endpoint.dart   # Judging & time-travel controls
    │
    └── greetings/
        └── endpoints/greeting_endpoint.dart
```

---

## 🔒 Atomic Raw SQL Counter Invariant

To eliminate lost-update race conditions when multiple students concurrently submit answers, question counters (`attemptCount`, `attemptedStudentCount`, `solvedStudentCount`, `firstTrySolveCount`, `underTimeSolveCount`, `cleanSolveCount`) are updated via parameterized raw SQL queries (`unsafeExecute`):

```sql
UPDATE question 
SET attemptCount = attemptCount + $1,
    attemptedStudentCount = attemptedStudentCount + $2,
    solvedStudentCount = solvedStudentCount + $3,
    firstTrySolveCount = firstTrySolveCount + $4,
    underTimeSolveCount = underTimeSolveCount + $5,
    cleanSolveCount = cleanSolveCount + $6
WHERE id = $7;
```

This guarantees **zero counter drift** under concurrent load, verified in `test/integration/concurrency_test.dart`.

---

## ⚡ Chromatic Reflex Tiers

| Tier | Verdict | Speed | Hint | Next Review | Feedback |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 🟢 **Mastered** | Correct | $\le$ Expected Time | No | +30 days | Instant Green Aura |
| 🟡 **Developing** | Correct | Slow / Helped | Yes/No | +1 or +2 days | Warning Yellow Aura |
| 🔴 **Needs Work** | Wrong | Any | Any | +1 day | Alert Red Aura |

---

## 🧪 Testing

```bash
# Run all unit and integration tests
dart test
```
- **Unit Tests:** Practice service, cohort stats, grader, card selector, scheduling policy, error reporter.
- **Integration Tests (`withServerpod`):** Full practice loop, zero answer leakage, scope denial.
- **Concurrency Test:** 10 simultaneous student submissions verifying atomic increments.
