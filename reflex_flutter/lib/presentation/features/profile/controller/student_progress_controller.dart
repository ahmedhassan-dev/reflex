import 'dart:async';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../client.dart';
import '../../../../core/storage/avatar_preferences.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../student_progress_screen.dart';

/// Controller for Student Progress / Profile Screen following arch_demo pattern.
abstract class StudentProgressController extends State<StudentProgressScreen> {
  late final IAnalyticsRepository analyticsRepo;

  // ── State variables ────────────────────────────────────────────────────────
  List<Course> courses = [];
  Course? selectedCourse;
  StudentProgress? progress;
  bool isLoading = false;
  String? errorMessage;

  String avatarId = 'student';
  int avatarColorValue = 0xFF10B981;
  String? profileImageUrl;
  bool isUploadingImage = false;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
    _loadSavedAvatar();
    _loadUserProfile();
    loadCoursesAndProgress();
  }

  Future<void> _loadUserProfile() async {
    final profile = await fetchCurrentUserProfile();
    if (mounted && profile.imageUrl != null) {
      setState(() {
        profileImageUrl = profile.imageUrl;
      });
    }
  }

  Future<void> _loadSavedAvatar() async {
    final savedId = await AvatarPreferences.getSavedAvatarId();
    final savedColor = await AvatarPreferences.getSavedAvatarColor();
    if (mounted && (savedId != null || savedColor != null)) {
      setState(() {
        if (savedId != null) avatarId = savedId;
        if (savedColor != null) avatarColorValue = savedColor;
      });
    }
  }

  Future<void> changeAvatar(String newId, int newColor) async {
    await AvatarPreferences.saveAvatar(newId, newColor);
    if (mounted) {
      setState(() {
        avatarId = newId;
        avatarColorValue = newColor;
      });
    }
  }

  Future<void> pickAndUploadImage() async {
    if (isDemoUserActive || !isUserAuthenticated) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.profile_image_authenticated_only.tr()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked == null) return;

      setState(() => isUploadingImage = true);

      final bytes = await picked.readAsBytes();
      final byteData = ByteData.view(
        bytes.buffer,
        bytes.offsetInBytes,
        bytes.lengthInBytes,
      );

      final updatedProfile = await client.userProfile.setUserImage(byteData);
      if (!mounted) return;
      setState(() {
        profileImageUrl = updatedProfile.imageUrl?.toString();
        isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.profile_image_updated.tr()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e, st) {
      debugPrint('[StudentProgressController.pickAndUploadImage] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (!mounted) return;
      setState(() => isUploadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.profile_image_upload_failed.tr()),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> removeProfileImage() async {
    if (isDemoUserActive || !isUserAuthenticated) return;
    try {
      setState(() => isUploadingImage = true);
      final updatedProfile = await client.userProfile.removeUserImage();
      if (!mounted) return;
      setState(() {
        profileImageUrl = updatedProfile.imageUrl?.toString();
        isUploadingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.profile_image_removed.tr()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e, st) {
      debugPrint('[StudentProgressController.removeProfileImage] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() => isUploadingImage = false);
      }
    }
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadCoursesAndProgress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final coursesRes = await analyticsRepo.listCourses();
    if (!mounted) return;

    if (coursesRes.isSuccess) {
      final list = coursesRes.data ?? [];
      courses = list;
      if (selectedCourse == null || !list.any((c) => c.id == selectedCourse?.id)) {
        selectedCourse = list.firstOrNull;
      }
    }

    await _fetchProgressForSelectedCourse();
  }

  Future<void> selectCourse(Course course) async {
    if (selectedCourse?.id == course.id) return;
    setState(() {
      selectedCourse = course;
    });
    await loadProgress();
  }

  Future<void> loadProgress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await _fetchProgressForSelectedCourse();
  }

  Future<void> _fetchProgressForSelectedCourse() async {
    final targetCourseId = selectedCourse?.id ?? 1;
    final res = await analyticsRepo.getMyProgress(targetCourseId);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoading = false;
        progress = res.data;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = res.error;
      });
    }
  }
}
