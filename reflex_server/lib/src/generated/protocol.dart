/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:reflex_server/src/generated/course.dart' as _ik7qkox3;
import 'package:reflex_server/src/generated/dtos/course_subscription_view.dart'
    as _iujwpemq;
import 'package:reflex_server/src/generated/question.dart' as _igqv87t7;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'accepted_answer.dart' as _im0rixu4;
import 'attempt.dart' as _iyzrlzh2;
import 'course.dart' as _ink5e3of;
import 'course_subscription.dart' as _iuhc77t0;
import 'demo_clock.dart' as _itaqwut4;
import 'dtos/cohort_summary.dart' as _il7knc0r;
import 'dtos/course_subscription_view.dart' as _iugqjajm;
import 'dtos/create_option_input.dart' as _i12skj47;
import 'dtos/create_question_input.dart' as _i83lwmh8;
import 'dtos/help_result.dart' as _ila2pk6h;
import 'dtos/option_explanation_view.dart' as _ihmvr8it;
import 'dtos/practice_item.dart' as _ijawaj3m;
import 'dtos/question_insight.dart' as _i3bmif37;
import 'dtos/question_option_view.dart' as _i7imv6rp;
import 'dtos/question_view.dart' as _it664drr;
import 'dtos/student_progress.dart' as _iv5t7noe;
import 'dtos/submit_result.dart' as _iqc0bdqv;
import 'dtos/topic_mastery.dart' as _ioklc517;
import 'enums/attempt_status.dart' as _ir7impgi;
import 'enums/card_kind.dart' as _i2hcehep;
import 'enums/question_type.dart' as _in2t4eqa;
import 'enums/reflex_tier.dart' as _i8m78wq8;
import 'enums/result_reason.dart' as _i3yqrgm0;
import 'enums/role.dart' as _iu4tij3a;
import 'enums/subscription_status.dart' as _i5d9goyo;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'learner.dart' as _iia065xp;
import 'question.dart' as _in6mynjk;
import 'question_option.dart' as _irpjihwh;
import 'review_state.dart' as _iiyeai10;
export 'accepted_answer.dart';
export 'attempt.dart';
export 'course.dart';
export 'course_subscription.dart';
export 'demo_clock.dart';
export 'dtos/cohort_summary.dart';
export 'dtos/course_subscription_view.dart';
export 'dtos/create_option_input.dart';
export 'dtos/create_question_input.dart';
export 'dtos/help_result.dart';
export 'dtos/option_explanation_view.dart';
export 'dtos/practice_item.dart';
export 'dtos/question_insight.dart';
export 'dtos/question_option_view.dart';
export 'dtos/question_view.dart';
export 'dtos/student_progress.dart';
export 'dtos/submit_result.dart';
export 'dtos/topic_mastery.dart';
export 'enums/attempt_status.dart';
export 'enums/card_kind.dart';
export 'enums/question_type.dart';
export 'enums/reflex_tier.dart';
export 'enums/result_reason.dart';
export 'enums/role.dart';
export 'enums/subscription_status.dart';
export 'greetings/greeting.dart';
export 'learner.dart';
export 'question.dart';
export 'question_option.dart';
export 'review_state.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'accepted_answer',
      dartName: 'AcceptedAnswer',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'questionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'normalizedText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'accepted_answer_qid_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'questionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'attempt',
      dartName: 'Attempt',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'learnerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'questionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'selectedOptionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'answerText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AttemptStatus',
        ),
        _isp.ColumnDefinition(
          name: 'responseMs',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'usedHelp',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'isFirstAttempt',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'underExpectedTime',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'isClean',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'reflexTier',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ReflexTier',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'attempt_learner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'learnerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'attempt_question_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'questionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'course',
      dartName: 'Course',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'topics',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'teacherId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'teacherName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isPublic',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'course_subscription',
      dartName: 'CourseSubscription',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'courseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SubscriptionStatus',
        ),
        _isp.ColumnDefinition(
          name: 'requestedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'decidedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'course_subscription_fk_0',
          columns: ['courseId'],
          referenceTable: 'course',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'course_subscription_fk_1',
          columns: ['studentId'],
          referenceTable: 'learner',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'course_student_sub_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'studentId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'demo_clock',
      dartName: 'DemoClock',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'offsetDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'learner',
      dartName: 'Learner',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Role',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'learner_auth_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'question',
      dartName: 'Question',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'courseId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'prompt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'topic',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'questionType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:QuestionType',
        ),
        _isp.ColumnDefinition(
          name: 'points',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'expectedSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'topicNote',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'helpHint',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'attemptCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'attemptedStudentCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'solvedStudentCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'firstTrySolveCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'underTimeSolveCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'cleanSolveCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'question_course_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'question_option',
      dartName: 'QuestionOption',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'questionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isCorrect',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'explanation',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'question_option_qid_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'questionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'review_state',
      dartName: 'ReviewState',
      schema: 'public',
      module: 'reflex',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'learnerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'questionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'dueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'intervalDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'lapses',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'helpUsed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'lastServedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'lastResult',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AttemptStatus?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'review_state_learner_q_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'learnerId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'questionId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _im0rixu4.AcceptedAnswer) {
      return _im0rixu4.AcceptedAnswer.fromJson(data) as T;
    }
    if (t == _iyzrlzh2.Attempt) {
      return _iyzrlzh2.Attempt.fromJson(data) as T;
    }
    if (t == _ink5e3of.Course) {
      return _ink5e3of.Course.fromJson(data) as T;
    }
    if (t == _iuhc77t0.CourseSubscription) {
      return _iuhc77t0.CourseSubscription.fromJson(data) as T;
    }
    if (t == _itaqwut4.DemoClock) {
      return _itaqwut4.DemoClock.fromJson(data) as T;
    }
    if (t == _il7knc0r.CohortSummary) {
      return _il7knc0r.CohortSummary.fromJson(data) as T;
    }
    if (t == _iugqjajm.CourseSubscriptionView) {
      return _iugqjajm.CourseSubscriptionView.fromJson(data) as T;
    }
    if (t == _i12skj47.CreateOptionInput) {
      return _i12skj47.CreateOptionInput.fromJson(data) as T;
    }
    if (t == _i83lwmh8.CreateQuestionInput) {
      return _i83lwmh8.CreateQuestionInput.fromJson(data) as T;
    }
    if (t == _ila2pk6h.HelpResult) {
      return _ila2pk6h.HelpResult.fromJson(data) as T;
    }
    if (t == _ihmvr8it.OptionExplanationView) {
      return _ihmvr8it.OptionExplanationView.fromJson(data) as T;
    }
    if (t == _ijawaj3m.PracticeItem) {
      return _ijawaj3m.PracticeItem.fromJson(data) as T;
    }
    if (t == _i3bmif37.QuestionInsight) {
      return _i3bmif37.QuestionInsight.fromJson(data) as T;
    }
    if (t == _i7imv6rp.QuestionOptionView) {
      return _i7imv6rp.QuestionOptionView.fromJson(data) as T;
    }
    if (t == _it664drr.QuestionView) {
      return _it664drr.QuestionView.fromJson(data) as T;
    }
    if (t == _iv5t7noe.StudentProgress) {
      return _iv5t7noe.StudentProgress.fromJson(data) as T;
    }
    if (t == _iqc0bdqv.SubmitResult) {
      return _iqc0bdqv.SubmitResult.fromJson(data) as T;
    }
    if (t == _ioklc517.TopicMastery) {
      return _ioklc517.TopicMastery.fromJson(data) as T;
    }
    if (t == _ir7impgi.AttemptStatus) {
      return _ir7impgi.AttemptStatus.fromJson(data) as T;
    }
    if (t == _i2hcehep.CardKind) {
      return _i2hcehep.CardKind.fromJson(data) as T;
    }
    if (t == _in2t4eqa.QuestionType) {
      return _in2t4eqa.QuestionType.fromJson(data) as T;
    }
    if (t == _i8m78wq8.ReflexTier) {
      return _i8m78wq8.ReflexTier.fromJson(data) as T;
    }
    if (t == _i3yqrgm0.ResultReason) {
      return _i3yqrgm0.ResultReason.fromJson(data) as T;
    }
    if (t == _iu4tij3a.Role) {
      return _iu4tij3a.Role.fromJson(data) as T;
    }
    if (t == _i5d9goyo.SubscriptionStatus) {
      return _i5d9goyo.SubscriptionStatus.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _iia065xp.Learner) {
      return _iia065xp.Learner.fromJson(data) as T;
    }
    if (t == _in6mynjk.Question) {
      return _in6mynjk.Question.fromJson(data) as T;
    }
    if (t == _irpjihwh.QuestionOption) {
      return _irpjihwh.QuestionOption.fromJson(data) as T;
    }
    if (t == _iiyeai10.ReviewState) {
      return _iiyeai10.ReviewState.fromJson(data) as T;
    }
    if (t == _is.getType<_im0rixu4.AcceptedAnswer?>()) {
      return (data != null ? _im0rixu4.AcceptedAnswer.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyzrlzh2.Attempt?>()) {
      return (data != null ? _iyzrlzh2.Attempt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ink5e3of.Course?>()) {
      return (data != null ? _ink5e3of.Course.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iuhc77t0.CourseSubscription?>()) {
      return (data != null ? _iuhc77t0.CourseSubscription.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_itaqwut4.DemoClock?>()) {
      return (data != null ? _itaqwut4.DemoClock.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_il7knc0r.CohortSummary?>()) {
      return (data != null ? _il7knc0r.CohortSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iugqjajm.CourseSubscriptionView?>()) {
      return (data != null
              ? _iugqjajm.CourseSubscriptionView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i12skj47.CreateOptionInput?>()) {
      return (data != null ? _i12skj47.CreateOptionInput.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i83lwmh8.CreateQuestionInput?>()) {
      return (data != null
              ? _i83lwmh8.CreateQuestionInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ila2pk6h.HelpResult?>()) {
      return (data != null ? _ila2pk6h.HelpResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihmvr8it.OptionExplanationView?>()) {
      return (data != null
              ? _ihmvr8it.OptionExplanationView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ijawaj3m.PracticeItem?>()) {
      return (data != null ? _ijawaj3m.PracticeItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3bmif37.QuestionInsight?>()) {
      return (data != null ? _i3bmif37.QuestionInsight.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7imv6rp.QuestionOptionView?>()) {
      return (data != null ? _i7imv6rp.QuestionOptionView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_it664drr.QuestionView?>()) {
      return (data != null ? _it664drr.QuestionView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv5t7noe.StudentProgress?>()) {
      return (data != null ? _iv5t7noe.StudentProgress.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqc0bdqv.SubmitResult?>()) {
      return (data != null ? _iqc0bdqv.SubmitResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioklc517.TopicMastery?>()) {
      return (data != null ? _ioklc517.TopicMastery.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir7impgi.AttemptStatus?>()) {
      return (data != null ? _ir7impgi.AttemptStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2hcehep.CardKind?>()) {
      return (data != null ? _i2hcehep.CardKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in2t4eqa.QuestionType?>()) {
      return (data != null ? _in2t4eqa.QuestionType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8m78wq8.ReflexTier?>()) {
      return (data != null ? _i8m78wq8.ReflexTier.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3yqrgm0.ResultReason?>()) {
      return (data != null ? _i3yqrgm0.ResultReason.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu4tij3a.Role?>()) {
      return (data != null ? _iu4tij3a.Role.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5d9goyo.SubscriptionStatus?>()) {
      return (data != null ? _i5d9goyo.SubscriptionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iia065xp.Learner?>()) {
      return (data != null ? _iia065xp.Learner.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in6mynjk.Question?>()) {
      return (data != null ? _in6mynjk.Question.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irpjihwh.QuestionOption?>()) {
      return (data != null ? _irpjihwh.QuestionOption.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iiyeai10.ReviewState?>()) {
      return (data != null ? _iiyeai10.ReviewState.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_ioklc517.TopicMastery>) {
      return (data as List)
              .map((e) => deserialize<_ioklc517.TopicMastery>(e))
              .toList()
          as T;
    }
    if (t == List<_i3bmif37.QuestionInsight>) {
      return (data as List)
              .map((e) => deserialize<_i3bmif37.QuestionInsight>(e))
              .toList()
          as T;
    }
    if (t == List<_iv5t7noe.StudentProgress>) {
      return (data as List)
              .map((e) => deserialize<_iv5t7noe.StudentProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i12skj47.CreateOptionInput>) {
      return (data as List)
              .map((e) => deserialize<_i12skj47.CreateOptionInput>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i12skj47.CreateOptionInput>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12skj47.CreateOptionInput>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i7imv6rp.QuestionOptionView>) {
      return (data as List)
              .map((e) => deserialize<_i7imv6rp.QuestionOptionView>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i7imv6rp.QuestionOptionView>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i7imv6rp.QuestionOptionView>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ihmvr8it.OptionExplanationView>) {
      return (data as List)
              .map((e) => deserialize<_ihmvr8it.OptionExplanationView>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ihmvr8it.OptionExplanationView>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ihmvr8it.OptionExplanationView>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ik7qkox3.Course>) {
      return (data as List)
              .map((e) => deserialize<_ik7qkox3.Course>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_iujwpemq.CourseSubscriptionView>) {
      return (data as List)
              .map((e) => deserialize<_iujwpemq.CourseSubscriptionView>(e))
              .toList()
          as T;
    }
    if (t == List<_igqv87t7.Question>) {
      return (data as List)
              .map((e) => deserialize<_igqv87t7.Question>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _im0rixu4.AcceptedAnswer => 'AcceptedAnswer',
      _iyzrlzh2.Attempt => 'Attempt',
      _ink5e3of.Course => 'Course',
      _iuhc77t0.CourseSubscription => 'CourseSubscription',
      _itaqwut4.DemoClock => 'DemoClock',
      _il7knc0r.CohortSummary => 'CohortSummary',
      _iugqjajm.CourseSubscriptionView => 'CourseSubscriptionView',
      _i12skj47.CreateOptionInput => 'CreateOptionInput',
      _i83lwmh8.CreateQuestionInput => 'CreateQuestionInput',
      _ila2pk6h.HelpResult => 'HelpResult',
      _ihmvr8it.OptionExplanationView => 'OptionExplanationView',
      _ijawaj3m.PracticeItem => 'PracticeItem',
      _i3bmif37.QuestionInsight => 'QuestionInsight',
      _i7imv6rp.QuestionOptionView => 'QuestionOptionView',
      _it664drr.QuestionView => 'QuestionView',
      _iv5t7noe.StudentProgress => 'StudentProgress',
      _iqc0bdqv.SubmitResult => 'SubmitResult',
      _ioklc517.TopicMastery => 'TopicMastery',
      _ir7impgi.AttemptStatus => 'AttemptStatus',
      _i2hcehep.CardKind => 'CardKind',
      _in2t4eqa.QuestionType => 'QuestionType',
      _i8m78wq8.ReflexTier => 'ReflexTier',
      _i3yqrgm0.ResultReason => 'ResultReason',
      _iu4tij3a.Role => 'Role',
      _i5d9goyo.SubscriptionStatus => 'SubscriptionStatus',
      _izw8z7ou.Greeting => 'Greeting',
      _iia065xp.Learner => 'Learner',
      _in6mynjk.Question => 'Question',
      _irpjihwh.QuestionOption => 'QuestionOption',
      _iiyeai10.ReviewState => 'ReviewState',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('reflex.', '');
    }

    switch (data) {
      case _im0rixu4.AcceptedAnswer():
        return 'AcceptedAnswer';
      case _iyzrlzh2.Attempt():
        return 'Attempt';
      case _ink5e3of.Course():
        return 'Course';
      case _iuhc77t0.CourseSubscription():
        return 'CourseSubscription';
      case _itaqwut4.DemoClock():
        return 'DemoClock';
      case _il7knc0r.CohortSummary():
        return 'CohortSummary';
      case _iugqjajm.CourseSubscriptionView():
        return 'CourseSubscriptionView';
      case _i12skj47.CreateOptionInput():
        return 'CreateOptionInput';
      case _i83lwmh8.CreateQuestionInput():
        return 'CreateQuestionInput';
      case _ila2pk6h.HelpResult():
        return 'HelpResult';
      case _ihmvr8it.OptionExplanationView():
        return 'OptionExplanationView';
      case _ijawaj3m.PracticeItem():
        return 'PracticeItem';
      case _i3bmif37.QuestionInsight():
        return 'QuestionInsight';
      case _i7imv6rp.QuestionOptionView():
        return 'QuestionOptionView';
      case _it664drr.QuestionView():
        return 'QuestionView';
      case _iv5t7noe.StudentProgress():
        return 'StudentProgress';
      case _iqc0bdqv.SubmitResult():
        return 'SubmitResult';
      case _ioklc517.TopicMastery():
        return 'TopicMastery';
      case _ir7impgi.AttemptStatus():
        return 'AttemptStatus';
      case _i2hcehep.CardKind():
        return 'CardKind';
      case _in2t4eqa.QuestionType():
        return 'QuestionType';
      case _i8m78wq8.ReflexTier():
        return 'ReflexTier';
      case _i3yqrgm0.ResultReason():
        return 'ResultReason';
      case _iu4tij3a.Role():
        return 'Role';
      case _i5d9goyo.SubscriptionStatus():
        return 'SubscriptionStatus';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _iia065xp.Learner():
        return 'Learner';
      case _in6mynjk.Question():
        return 'Question';
      case _irpjihwh.QuestionOption():
        return 'QuestionOption';
      case _iiyeai10.ReviewState():
        return 'ReviewState';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcceptedAnswer') {
      return deserialize<_im0rixu4.AcceptedAnswer>(data['data']);
    }
    if (dataClassName == 'Attempt') {
      return deserialize<_iyzrlzh2.Attempt>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_ink5e3of.Course>(data['data']);
    }
    if (dataClassName == 'CourseSubscription') {
      return deserialize<_iuhc77t0.CourseSubscription>(data['data']);
    }
    if (dataClassName == 'DemoClock') {
      return deserialize<_itaqwut4.DemoClock>(data['data']);
    }
    if (dataClassName == 'CohortSummary') {
      return deserialize<_il7knc0r.CohortSummary>(data['data']);
    }
    if (dataClassName == 'CourseSubscriptionView') {
      return deserialize<_iugqjajm.CourseSubscriptionView>(data['data']);
    }
    if (dataClassName == 'CreateOptionInput') {
      return deserialize<_i12skj47.CreateOptionInput>(data['data']);
    }
    if (dataClassName == 'CreateQuestionInput') {
      return deserialize<_i83lwmh8.CreateQuestionInput>(data['data']);
    }
    if (dataClassName == 'HelpResult') {
      return deserialize<_ila2pk6h.HelpResult>(data['data']);
    }
    if (dataClassName == 'OptionExplanationView') {
      return deserialize<_ihmvr8it.OptionExplanationView>(data['data']);
    }
    if (dataClassName == 'PracticeItem') {
      return deserialize<_ijawaj3m.PracticeItem>(data['data']);
    }
    if (dataClassName == 'QuestionInsight') {
      return deserialize<_i3bmif37.QuestionInsight>(data['data']);
    }
    if (dataClassName == 'QuestionOptionView') {
      return deserialize<_i7imv6rp.QuestionOptionView>(data['data']);
    }
    if (dataClassName == 'QuestionView') {
      return deserialize<_it664drr.QuestionView>(data['data']);
    }
    if (dataClassName == 'StudentProgress') {
      return deserialize<_iv5t7noe.StudentProgress>(data['data']);
    }
    if (dataClassName == 'SubmitResult') {
      return deserialize<_iqc0bdqv.SubmitResult>(data['data']);
    }
    if (dataClassName == 'TopicMastery') {
      return deserialize<_ioklc517.TopicMastery>(data['data']);
    }
    if (dataClassName == 'AttemptStatus') {
      return deserialize<_ir7impgi.AttemptStatus>(data['data']);
    }
    if (dataClassName == 'CardKind') {
      return deserialize<_i2hcehep.CardKind>(data['data']);
    }
    if (dataClassName == 'QuestionType') {
      return deserialize<_in2t4eqa.QuestionType>(data['data']);
    }
    if (dataClassName == 'ReflexTier') {
      return deserialize<_i8m78wq8.ReflexTier>(data['data']);
    }
    if (dataClassName == 'ResultReason') {
      return deserialize<_i3yqrgm0.ResultReason>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_iu4tij3a.Role>(data['data']);
    }
    if (dataClassName == 'SubscriptionStatus') {
      return deserialize<_i5d9goyo.SubscriptionStatus>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'Learner') {
      return deserialize<_iia065xp.Learner>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_in6mynjk.Question>(data['data']);
    }
    if (dataClassName == 'QuestionOption') {
      return deserialize<_irpjihwh.QuestionOption>(data['data']);
    }
    if (dataClassName == 'ReviewState') {
      return deserialize<_iiyeai10.ReviewState>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('reflex', this);
    _iacs.Protocol().registerHostProtocol('reflex', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _im0rixu4.AcceptedAnswer:
        return _im0rixu4.AcceptedAnswer.t;
      case _iyzrlzh2.Attempt:
        return _iyzrlzh2.Attempt.t;
      case _ink5e3of.Course:
        return _ink5e3of.Course.t;
      case _iuhc77t0.CourseSubscription:
        return _iuhc77t0.CourseSubscription.t;
      case _itaqwut4.DemoClock:
        return _itaqwut4.DemoClock.t;
      case _iia065xp.Learner:
        return _iia065xp.Learner.t;
      case _in6mynjk.Question:
        return _in6mynjk.Question.t;
      case _irpjihwh.QuestionOption:
        return _irpjihwh.QuestionOption.t;
      case _iiyeai10.ReviewState:
        return _iiyeai10.ReviewState.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'reflex';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
