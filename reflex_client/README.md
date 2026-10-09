# Reflex Client 🔌

The generated client library for **Reflex**, providing type-safe RPC communication between the Flutter frontend and the Serverpod backend.

---

## 📦 What's Inside

- **Generated Endpoints:**
  - `client.practice`: Card serving (`serveNextCard`), hint requesting (`requestHelp`), and answer submission (`submitAnswer`).
  - `client.analytics`: Cohort summary metrics (`getCohortSummary`) and student progress (`getMyProgress`).
  - `client.questionAdmin`: Teacher question management (`listQuestions`, `updateTopicNoteAndHint`).
  - `client.demoClock`: Virtual clock controls (`getOffsetDays`, `advanceDays`, `resetClock`).
- **DTOs with Zero Answer Leakage:**
  - `PracticeItem`: Bundles `QuestionView` without exposing correct answer keys or rationales prior to submission.
  - `SubmitResult`: Reveals `reflexTier`, verdict, points, latency, compulsory `topicNote`, and MCQ `optionExplanations` only after grading.

---

## 🔄 Code Generation

Whenever endpoint signatures or `.spy.yaml` models change in `reflex_server`, regenerate the client by running:

```bash
cd ../reflex_server
serverpod generate
```
