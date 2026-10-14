BEGIN;

--
-- 1. Create table profile (preserving data from learner if it exists)
--
CREATE TABLE IF NOT EXISTS "profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL,
    "fcmToken" text,
    "email" text
);

DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'learner') THEN
        INSERT INTO "profile" ("id", "authUserId", "displayName", "role", "fcmToken")
        SELECT "id", "authUserId", "displayName", "role", "fcmToken" FROM "learner"
        ON CONFLICT ("id") DO NOTHING;
        PERFORM setval(pg_get_serial_sequence('"profile"', 'id'), coalesce(max(id), 1)) FROM "profile";
        DROP TABLE "learner" CASCADE;
    END IF;
END $$;

CREATE UNIQUE INDEX IF NOT EXISTS "profile_auth_idx" ON "profile" USING btree ("authUserId");

--
-- 2. Migrate attempt table: rename learnerId -> profileId or create if new
--
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'attempt' AND column_name = 'learnerId') THEN
        ALTER TABLE "attempt" RENAME COLUMN "learnerId" TO "profileId";
        DROP INDEX IF EXISTS "attempt_learner_idx";
        CREATE INDEX IF NOT EXISTS "attempt_profile_idx" ON "attempt" USING btree ("profileId");
    ELSIF NOT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'attempt') THEN
        CREATE TABLE "attempt" (
            "id" bigserial PRIMARY KEY,
            "profileId" bigint NOT NULL,
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
        CREATE INDEX "attempt_profile_idx" ON "attempt" USING btree ("profileId");
        CREATE INDEX "attempt_question_idx" ON "attempt" USING btree ("questionId");
    END IF;
END $$;

--
-- 3. Migrate review_state table: rename learnerId -> profileId or create if new
--
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.columns WHERE table_name = 'review_state' AND column_name = 'learnerId') THEN
        ALTER TABLE "review_state" RENAME COLUMN "learnerId" TO "profileId";
        DROP INDEX IF EXISTS "review_state_learner_q_idx";
        CREATE UNIQUE INDEX IF NOT EXISTS "review_state_profile_q_idx" ON "review_state" USING btree ("profileId", "questionId");
    ELSIF NOT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'review_state') THEN
        CREATE TABLE "review_state" (
            "id" bigserial PRIMARY KEY,
            "profileId" bigint NOT NULL,
            "questionId" bigint NOT NULL,
            "dueAt" timestamp without time zone NOT NULL,
            "intervalDays" bigint NOT NULL,
            "lapses" bigint NOT NULL,
            "helpUsed" boolean NOT NULL,
            "lastServedAt" timestamp without time zone,
            "lastResult" text
        );
        CREATE UNIQUE INDEX "review_state_profile_q_idx" ON "review_state" USING btree ("profileId", "questionId");
    END IF;
END $$;

--
-- 4. Update foreign keys on course_subscription
--
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'course_subscription') THEN
        CREATE TABLE "course_subscription" (
            "id" bigserial PRIMARY KEY,
            "courseId" bigint NOT NULL,
            "studentId" bigint NOT NULL,
            "status" text NOT NULL,
            "requestedAt" timestamp without time zone NOT NULL,
            "decidedAt" timestamp without time zone
        );
        CREATE UNIQUE INDEX "course_student_sub_idx" ON "course_subscription" USING btree ("courseId", "studentId");
    END IF;
END $$;

ALTER TABLE ONLY "course_subscription"
    DROP CONSTRAINT IF EXISTS "course_subscription_fk_1";
ALTER TABLE ONLY "course_subscription"
    DROP CONSTRAINT IF EXISTS "course_subscription_fk_0";

ALTER TABLE ONLY "course_subscription"
    ADD CONSTRAINT "course_subscription_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "course_subscription"
    ADD CONSTRAINT "course_subscription_fk_1"
    FOREIGN KEY("studentId")
    REFERENCES "profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR reflex
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('reflex', '20261014161744841', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014161744841', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

COMMIT;
