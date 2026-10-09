# Competition Scope UML Diagrams (v2 - Competition Slice)

> Generated for the Serverpod Hackathon Rebuild (Scope: One complete practice loop + topic notes + help tracking + question counters + Flutter MVVM + Serverpod MVC/CSR + Sentry + easy_localization).

| # | File | Title | Kind | Purpose / Key Insights |
|---|------|-------|------|------------------------|
| 01 | [01_use_case.png](01_use_case.png) | Reflex Use Case Diagram | UML Use Case | Reflex competition scope: MCQ & text practice, chromatic feedback (Green/Yellow/Red), topic notes gate, help tracking, question counters, teacher dashboard. |
| 02 | [02_component_architecture.png](02_component_architecture.png) | Reflex Component & Architecture Diagram | UML Component | Flutter MVVM client communicating via Serverpod client to Serverpod backend (Controller -> Service -> Repository), with Sentry and easy_localization. |
| 03 | [03_class_domain.png](03_class_domain.png) | Reflex Domain Models & Protocol DTOs | UML Class | Data entities (.spy.yaml) and DTOs. Includes QuestionType, QuestionOption, OptionExplanationView, and ReflexTier chromatic feedback. |
| 04 | [04_class_server_layers.png](04_class_server_layers.png) | Serverpod Clean Architecture Layers (CSR) | UML Class | Controller-Service-Repository pattern. Endpoints are thin controllers. Services contain pure domain logic. Repositories handle database and atomic SQL. |
| 05 | [05_er_diagram.png](05_er_diagram.png) | PostgreSQL ER Diagram | ER Diagram | Relational schema: course, question (with 6 counters), question_option (with explanations), accepted_answer, learner, attempt, review_state, demo_clock. |
| 06 | [06_sequence_next_card.png](06_sequence_next_card.png) | Next Card Request Flow (MCQ or Text) | UML Sequence | Student requests next card. Server selects overdue card or new card, stamps lastServedAt, and strips answer key, option correctness, and topic notes. |
| 07 | [07_sequence_request_help.png](07_sequence_request_help.png) | Need Help & Hint Reveal Flow | UML Sequence | Student requests hint. Server records helpUsed=true on active ReviewState (capping scheduling to +1 day) and returns hint. |
| 08 | [08_sequence_submit_answer.png](08_sequence_submit_answer.png) | Submit Answer, Chromatic Feedback & Explanations | UML Sequence | Submission evaluated, Reflex tier assigned (Green/Yellow/Red), atomic transaction executed, and SubmitResult returns color, option notes, and topic note. |
| 09 | [09_state_machine_card.png](09_state_machine_card.png) | Card Spaced Repetition State Machine | UML State | Lifecycle of a card per student: Unseen -> Due (Review) -> Active -> Chromatic Result -> Mastered / Retrying. |
| 10 | [10_activity_outcome_and_counters.png](10_activity_outcome_and_counters.png) | Reflex Attempt Outcome & Chromatic Classifier | UML Activity | Detailed decision logic: evaluates MCQ or Text, computes ReflexTier (Green/Yellow/Red), applies intervals, and increments Question counters atomically. |
| 11 | [11_sequence_dashboard.png](11_sequence_dashboard.png) | Teacher Analytics & Chromatic Distribution | UML Sequence | Teacher loads dashboard. Server aggregates topic mastery, question insights with 6 counters, student clean solves, and chromatic level breakdown. |
| 12 | [12_class_flutter_mvvm.png](12_class_flutter_mvvm.png) | Flutter MVVM Architecture & Chromatic UI State | UML Class | MVVM layer: View binds to ViewModel, observes sealed PracticeUiState, applies ReflexTier colors, and uses LocaleKeys for localization. |
| 13 | [13_sequence_submit_note_gate.png](13_sequence_submit_note_gate.png) | Post-Submission Explanations & Topic Note Gate | UML Sequence | After submission, student sees chromatic color (Red/Yellow/Green), why the option was right/wrong, and topic note. Continue button locked until acknowledged. |
| 14 | [14_sequence_error_reporting.png](14_sequence_error_reporting.png) | Reflex Sentry Error Telemetry Flow | UML Sequence | Serverpod diagnostic event handler and Flutter sentry_flutter capture exceptions, with PII and answer scrubbing, plus a debug crash trigger. |

## How to re-render
```bash
python3 scratch/render_diagrams.py
```
