import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../generated/locale_keys.g.dart';
import '../core/theme/app_colors.dart';
import '../features/analytics/analytics_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/demo_clock/widgets/demo_clock_widget.dart';
import '../features/practice/practice_screen.dart';
import '../features/profile/student_progress_screen.dart';
import '../features/question_admin/question_admin_screen.dart';

/// App shell providing role-tailored navigation for Students and Teachers,
/// collapsible Demo Clock time machine, and smooth role switching.
class AppShell extends StatefulWidget {
  final Role initialRole;
  final String? userName;

  const AppShell({
    super.key,
    this.initialRole = Role.student,
    this.userName,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late Role _currentRole;
  int _currentIndex = 0;
  bool _showTimeMachine = false;

  @override
  void initState() {
    super.initState();
    _currentRole = widget.initialRole;
  }

  void _onClockShifted() {
    // Rebuild active screens when simulated time advances
    setState(() {});
  }

  void _switchToAuthScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = _currentRole == Role.student;
    final roleColor = isStudent ? ReflexColors.primary : ReflexColors.accent;
    final roleBadgeText = isStudent
        ? LocaleKeys.auth_role_student_badge.tr()
        : LocaleKeys.auth_role_teacher_badge.tr();

    // Students have Practice & My Progress; Teachers have Analytics Dashboard & Question Notes
    final destinations = isStudent
        ? [
            NavigationDestination(
              icon: const Icon(Icons.psychology_outlined),
              selectedIcon: const Icon(Icons.psychology_rounded),
              label: LocaleKeys.nav_practice.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: const Icon(Icons.person_rounded),
              label: LocaleKeys.nav_profile.tr(),
            ),
          ]
        : [
            NavigationDestination(
              icon: const Icon(Icons.analytics_outlined),
              selectedIcon: const Icon(Icons.analytics_rounded),
              label: LocaleKeys.nav_dashboard.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.edit_note_outlined),
              selectedIcon: const Icon(Icons.edit_note_rounded),
              label: LocaleKeys.nav_questions.tr(),
            ),
          ];

    final screens = isStudent
        ? [
            PracticeScreen(
              key: ValueKey('practice_student_$_currentIndex'),
            ),
            StudentProgressScreen(
              key: ValueKey('profile_student_$_currentIndex'),
              userName: widget.userName,
            ),
          ]
        : [
            AnalyticsScreen(
              key: ValueKey('analytics_teacher_$_currentIndex'),
            ),
            QuestionAdminScreen(
              key: ValueKey('admin_teacher_$_currentIndex'),
            ),
          ];

    final safeIndex = _currentIndex < screens.length ? _currentIndex : 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ReflexColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.flash_on_rounded,
                color: ReflexColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              LocaleKeys.app_title.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            // Persona Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: roleColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: roleColor.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isStudent ? Icons.school_rounded : Icons.co_present_rounded,
                    size: 14,
                    color: roleColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.userName != null
                        ? '${widget.userName} ($roleBadgeText)'
                        : roleBadgeText,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: roleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Switch Role button
          IconButton(
            key: const Key('btn_switch_role'),
            icon: const Icon(Icons.swap_horiz_rounded),
            tooltip: LocaleKeys.auth_switch_role.tr(),
            onPressed: _switchToAuthScreen,
          ),
          // Time Machine toggle button
          IconButton(
            icon: Icon(
              Icons.access_time_filled_rounded,
              color: _showTimeMachine ? ReflexColors.accent : null,
            ),
            tooltip: LocaleKeys.demo_clock_title.tr(),
            onPressed: () {
              setState(() {
                _showTimeMachine = !_showTimeMachine;
              });
            },
          ),
          // Language toggle button
          IconButton(
            icon: const Icon(Icons.language_rounded),
            tooltip: LocaleKeys.switch_language.tr(),
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          if (_showTimeMachine) ...[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
              child: DemoClockWidget(
                onClockShifted: _onClockShifted,
              ),
            ),
          ],
          Expanded(
            child: IndexedStack(
              index: safeIndex,
              children: screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: safeIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: destinations,
      ),
    );
  }
}
