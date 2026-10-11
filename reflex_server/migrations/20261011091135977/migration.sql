BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "course" ADD COLUMN "teacherId" bigint;
ALTER TABLE "course" ADD COLUMN "teacherName" text;
ALTER TABLE "course" ADD COLUMN "isPublic" boolean;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_subscription" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "studentId" bigint NOT NULL,
    "status" text NOT NULL,
    "requestedAt" timestamp without time zone NOT NULL,
    "decidedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "course_student_sub_idx" ON "course_subscription" USING btree ("courseId", "studentId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "course_subscription"
    ADD CONSTRAINT "course_subscription_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "course"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_subscription"
    ADD CONSTRAINT "course_subscription_fk_1"
    FOREIGN KEY("studentId")
    REFERENCES "learner"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR reflex
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('reflex', '20261011091135977', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261011091135977', "timestamp" = now();

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
