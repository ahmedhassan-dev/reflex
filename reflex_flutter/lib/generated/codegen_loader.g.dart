// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "app_title": "Reflex",
  "connected": "You are connected",
  "sign_out": "Sign out",
  "sign_in": "Sign in",
  "enter_name": "Enter your name",
  "no_response_yet": "No server response yet.",
  "error_occurred": "An error occurred",
  "retry": "Retry",
  "loading": "Loading...",
  "practice": {
    "title": "Practice",
    "submit": "Submit Answer",
    "continue_button": "Continue",
    "hint": "Hint",
    "points": "points",
    "note_gate_title": "Topic Note",
    "note_gate_acknowledge": "I have read and understood this note",
    "mastered": "Mastered (Reflex Fast & Clean)",
    "developing": "Developing (Correct, Keep Practicing)",
    "needs_work": "Needs Work (Review Needed)"
  },
  "dashboard": {
    "title": "Teacher Dashboard",
    "cohort_mastery": "Cohort Mastery",
    "questions": "Question Insights",
    "students": "Student Progress"
  }
};
static const Map<String,dynamic> _ar = {
  "app_title": "ريفلكس",
  "connected": "أنت متصل الآن",
  "sign_out": "تسجيل الخروج",
  "sign_in": "تسجيل الدخول",
  "enter_name": "أدخل اسمك",
  "no_response_yet": "لا يوجد رد من الخادم حتى الآن.",
  "error_occurred": "حدث خطأ",
  "retry": "إعادة المحاولة",
  "loading": "جارٍ التحميل...",
  "practice": {
    "title": "التدريب",
    "submit": "إرسال الإجابة",
    "continue_button": "متابعة",
    "hint": "تلميح",
    "points": "نقاط",
    "note_gate_title": "ملاحظة الموضوع",
    "note_gate_acknowledge": "قرأت هذه الملاحظة وفهمتها",
    "mastered": "متقن (ريفلكس سريع وبدون مساعدة)",
    "developing": "في طور التطوير (صحيح، تابع التدريب)",
    "needs_work": "يحتاج مراجعة (غير صحيح)"
  },
  "dashboard": {
    "title": "لوحة تحكم المعلم",
    "cohort_mastery": "إتقان الفصل الدراسي",
    "questions": "تحليلات الأسئلة",
    "students": "تقدم الطلاب"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "ar": _ar};
}
