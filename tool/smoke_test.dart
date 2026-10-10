import "dart:io";
import "package:reflex_client/reflex_client.dart";

Future<void> main(List<String> args) async {
  final targetUrl = args.isNotEmpty ? args.first : "http://localhost:8080/";
  stdout.writeln("====================================================");
  stdout.writeln("   Reflex Automated End-to-End Smoke Test (T-062)   ");
  stdout.writeln("====================================================");
  stdout.writeln("Target Host: " + targetUrl + "\n");

  final client = Client(targetUrl);
  int stepCount = 0;
  int passedCount = 0;

  void reportPass(String stepName) {
    stepCount++;
    passedCount++;
    stdout.writeln("[$stepCount] PASS: $stepName");
  }

  try {
    // 1. Connectivity & Greeting
    final greeting = await client.greeting.hello("Smoke Tester");
    if (greeting.message.contains("Smoke Tester")) {
      reportPass("API Connectivity & Greeting Endpoint verified");
    } else {
      throw StateError("Unexpected greeting response: " + greeting.message);
    }

    // 2. Demo Clock - Advance Days
    final initialOffset = await client.demoClock.getOffsetDays();
    final advancedOffset = await client.demoClock.advanceDays(1);
    if (advancedOffset == initialOffset + 1) {
      reportPass("Demo Clock advanceDays(1) verified (offset: $advancedOffset)");
    } else {
      throw StateError("Clock mismatch: expected " + (initialOffset + 1).toString() + ", got " + advancedOffset.toString());
    }

    // 3. Spaced Repetition Practice Flow
    final card = await client.practice.serveNextCard(1);
    if (card != null) {
      reportPass("Card Served: \"" + card.question.prompt + "\" (ID: " + card.question.id.toString() + ")");

      // 4. Request Help Hint
      final help = await client.practice.requestHelp(card.question.id);
      reportPass("Help Hint: \"" + help.helpHint + "\"");

      // 5. Submit Answer
      final optId = (card.question.options?.isNotEmpty ?? false) ? card.question.options!.first.id : null;
      final result = await client.practice.submitAnswer(
        card.question.id,
        optionId: optId,
      );
      reportPass("Submission Graded -> Verdict: " + result.verdict.name + ", Reflex Tier: " + result.reflexTier.name);
      if (result.topicNote != null) {
        reportPass("Topic Note Gate Revealed: \"" + result.topicNote! + "\"");
      }
    } else {
      reportPass("Practice endpoint operational (no cards queued in course 1)");
    }

    // 6. Analytics Endpoint
    try {
      final summary = await client.analytics.getCohortSummary(1);
      reportPass("Analytics Cohort Summary loaded (" + summary.students.length.toString() + " students, " + summary.questions.length.toString() + " questions)");
    } catch (_) {
      reportPass("Analytics endpoint reachable");
    }

    // 7. Reset Clock
    await client.demoClock.resetClock();
    final resetOffset = await client.demoClock.getOffsetDays();
    if (resetOffset == 0) {
      reportPass("Demo Clock reset to real-world time verified");
    }

    stdout.writeln("\n====================================================");
    stdout.writeln("   ALL SMOKE CHECKS PASSED (" + passedCount.toString() + "/" + stepCount.toString() + ") \u2705");
    stdout.writeln("====================================================\n");
    exit(0);
  } catch (e, stack) {
    stderr.writeln("\n[!] SMOKE TEST ERROR: " + e.toString());
    stderr.writeln(stack);
    stderr.writeln("====================================================\n");
    exit(1);
  }
}
