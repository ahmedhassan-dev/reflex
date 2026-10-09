BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "accepted_answer" (
    "id" bigserial PRIMARY KEY,
    "questionId" bigint NOT NULL,
    "normalizedText" text NOT NULL
);

-- Indexes
CREATE INDEX "accepted_answer_qid_idx" ON "accepted_answer" USING btree ("questionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attempt" (
    "id" bigserial PRIMARY KEY,
    "learnerId" bigint NOT NULL,
    "questionId" bigint NOT NULL,
    "selectedOptionId" bigint,
    "answerText" text,
    "status" text NOT NULL,
    "responseMs" bigint NOT NULL,
    "usedHelp" boolean NOT NULL,
    "isFirstAttempt" boolean NOT NULL,
    "underExpectedTime" boolean NOT NULL,
    "isClean" boolean NOT NULL,
    "reflexTier" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "attempt_learner_idx" ON "attempt" USING btree ("learnerId");
CREATE INDEX "attempt_question_idx" ON "attempt" USING btree ("questionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "subject" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "demo_clock" (
    "id" bigserial PRIMARY KEY,
    "offsetDays" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "learner" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "learner_auth_idx" ON "learner" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "prompt" text NOT NULL,
    "topic" text NOT NULL,
    "questionType" text NOT NULL,
    "points" bigint NOT NULL,
    "expectedSeconds" bigint NOT NULL,
    "topicNote" text,
    "helpHint" text,
    "attemptCount" bigint NOT NULL,
    "attemptedStudentCount" bigint NOT NULL,
    "solvedStudentCount" bigint NOT NULL,
    "firstTrySolveCount" bigint NOT NULL,
    "underTimeSolveCount" bigint NOT NULL,
    "cleanSolveCount" bigint NOT NULL
);

-- Indexes
CREATE INDEX "question_course_idx" ON "question" USING btree ("courseId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "question_option" (
    "id" bigserial PRIMARY KEY,
    "questionId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "text" text NOT NULL,
    "isCorrect" boolean NOT NULL,
    "explanation" text
);

-- Indexes
CREATE INDEX "question_option_qid_idx" ON "question_option" USING btree ("questionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "review_state" (
    "id" bigserial PRIMARY KEY,
    "learnerId" bigint NOT NULL,
    "questionId" bigint NOT NULL,
    "dueAt" timestamp without time zone NOT NULL,
    "intervalDays" bigint NOT NULL,
    "lapses" bigint NOT NULL,
    "helpUsed" boolean NOT NULL,
    "lastServedAt" timestamp without time zone,
    "lastResult" text
);

-- Indexes
CREATE UNIQUE INDEX "review_state_learner_q_idx" ON "review_state" USING btree ("learnerId", "questionId");


--
-- MIGRATION VERSION FOR reflex
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('reflex', '20261009065309214', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261009065309214', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
