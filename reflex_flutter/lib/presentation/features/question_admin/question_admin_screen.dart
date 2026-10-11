import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/question_admin_repository.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/question_admin_controller.dart';
import 'widgets/admin_course_header.dart';
import 'widgets/admin_question_editor.dart';
import 'widgets/course_subscriptions_sheet.dart';
import 'widgets/create_course_dialog.dart';
import 'widgets/create_question_bottom_sheet.dart';

/// Screen allowing teachers to browse courses, add new courses, add new questions,
/// manage student subscriptions, and edit concept explanations and hints.
class QuestionAdminScreen extends StatefulWidget {
  final IQuestionAdminRepository? repositoryOverride;

  const QuestionAdminScreen({
    super.key,
    this.repositoryOverride,
  });

  @override
  State<QuestionAdminScreen> createState() => _QuestionAdminScreenState();
}

class _QuestionAdminScreenState extends QuestionAdminController {
  void _openCreateCourseDialog() {
    CreateCourseDialog.show(
      context,
      onCreateCourse: ({
        required String title,
        required String subject,
        List<String>? topics,
        required bool isPublic,
      }) {
        return createNewCourse(
          title: title,
          subject: subject,
          topics: topics,
          isPublic: isPublic,
        );
      },
    );
  }

  void _openSubscriptionsSheet() {
    CourseSubscriptionsSheet.show(
      context,
      selectedCourse: selectedCourse,
      subscriptions: subscriptions,
      isLoadingSubscriptions: isLoadingSubscriptions,
      onRespondToSubscription: respondToSubscription,
    );
  }

  void _openCreateQuestionDialog() {
    CreateQuestionBottomSheet.show(
      context,
      courseId: courseId,
      onCreateQuestion: createNewQuestion,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AdminCourseHeader(
                    courses: courses,
                    selectedCourse: selectedCourse,
                    courseId: courseId,
                    subscriptions: subscriptions,
                    onCourseSelected: onCourseSelected,
                    onAddCourse: _openCreateCourseDialog,
                    onToggleVisibility: toggleCourseVisibility,
                    onManageSubscriptions: _openSubscriptionsSheet,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.questions_admin_title.tr(),
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        key: const Key('btn_add_question'),
                        icon: const Icon(Icons.add_rounded, size: 18),
                        label: Text(
                            LocaleKeys.questions_admin_add_question_button.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ReflexColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _openCreateQuestionDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (questions.isEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(28),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: isDark
                                ? ReflexColors.darkBorder
                                : ReflexColors.lightBorder),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.quiz_outlined,
                              size: 48,
                              color: Colors.grey.withValues(alpha: 0.5)),
                          const SizedBox(height: 12),
                          const Text(
                            'No questions in this course yet.\nTap "+ New Question" above to add the first problem!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Text(
                      LocaleKeys.questions_admin_select_question.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      key: const Key('dropdown_question_selector'),
                      initialValue: selectedQuestion?.id,
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      items: questions
                          .map((q) => DropdownMenuItem<int>(
                                value: q.id,
                                child: Text(
                                  '#${q.position} [${q.topic}] ${q.prompt}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (newId) {
                        if (newId != null) {
                          final found =
                              questions.where((q) => q.id == newId).firstOrNull;
                          if (found != null) {
                            selectQuestion(found);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    if (selectedQuestion != null)
                      AdminQuestionEditor(
                        selectedQuestion: selectedQuestion!,
                        topicNoteController: topicNoteController,
                        helpHintController: helpHintController,
                        isSaving: isSaving,
                        successMessage: successMessage,
                        errorMessage: errorMessage,
                        onSave: saveChanges,
                      ),
                  ],
                ],
              ),
            ),
    );
  }
}
