import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../data/repositories/practice_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../courses_screen.dart';

/// Controller for courses exploration and student subscriptions catalog.
abstract class CoursesController extends State<CoursesScreen> {
  late final IPracticeRepository practiceRepo;

  List<Course> courses = [];
  Map<int, SubscriptionStatus?> subscriptionStatuses = {};
  Set<int> requestingCourses = {};
  bool isLoading = false;
  String selectedFilter = 'all';
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    practiceRepo = widget.repositoryOverride ?? PracticeRepositoryImpl();
    loadCourses();
  }

  Future<void> loadCourses() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final res = await practiceRepo.listCourses();
      if (!mounted) return;

      if (res.isSuccess && res.data != null) {
        courses = res.data!;
        // Query subscription status for each private course
        final privateCourses = courses.where((c) => c.isPublic == false).toList();
        final statusesMap = <int, SubscriptionStatus?>{};

        for (final c in privateCourses) {
          if (c.id == null) continue;
          try {
            final statusRes = await practiceRepo.getCourseSubscriptionStatus(c.id!);
            if (statusRes.isSuccess) {
              statusesMap[c.id!] = statusRes.data;
            }
          } catch (e, st) {
            debugPrint('[CoursesController.loadCourses] status error: $e\n$st');
            unawaited(Sentry.captureException(e, stackTrace: st));
          }
        }

        setState(() {
          isLoading = false;
          subscriptionStatuses = statusesMap;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = res.error ?? LocaleKeys.error_occurred.tr();
        });
      }
    } catch (e, st) {
      debugPrint('[CoursesController.loadCourses] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
      }
    }
  }

  void setFilter(String filter) {
    if (selectedFilter != filter) {
      setState(() {
        selectedFilter = filter;
      });
    }
  }

  List<Course> get filteredCourses {
    if (selectedFilter == 'public') {
      return courses.where((c) => c.isPublic == true).toList();
    } else if (selectedFilter == 'private') {
      return courses.where((c) => c.isPublic == false).toList();
    }
    return courses;
  }

  Future<void> requestSubscription(Course course) async {
    final courseId = course.id;
    if (courseId == null || requestingCourses.contains(courseId)) return;

    setState(() {
      requestingCourses.add(courseId);
    });

    try {
      final res = await practiceRepo.requestCourseSubscription(courseId);
      if (!mounted) return;

      setState(() {
        requestingCourses.remove(courseId);
      });

      if (res.isSuccess) {
        setState(() {
          subscriptionStatuses[courseId] =
              res.data?.status ?? SubscriptionStatus.pending;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.subscriptions_request_sent_success.tr()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.error ?? LocaleKeys.error_occurred.tr()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e, st) {
      debugPrint('[CoursesController.requestSubscription] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() {
          requestingCourses.remove(courseId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> refreshCourseStatus(int courseId) async {
    try {
      final statusRes = await practiceRepo.getCourseSubscriptionStatus(courseId);
      if (!mounted) return;
      if (statusRes.isSuccess) {
        setState(() {
          subscriptionStatuses[courseId] = statusRes.data;
        });
      }
    } catch (e, st) {
      debugPrint('[CoursesController.refreshCourseStatus] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }
}
