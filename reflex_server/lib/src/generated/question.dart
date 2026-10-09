/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'enums/question_type.dart' as _in2t4eqa;

abstract class Question
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Question._({
    this.id,
    required this.courseId,
    required this.position,
    required this.prompt,
    required this.topic,
    required this.questionType,
    required this.points,
    required this.expectedSeconds,
    this.topicNote,
    this.helpHint,
    required this.attemptCount,
    required this.attemptedStudentCount,
    required this.solvedStudentCount,
    required this.firstTrySolveCount,
    required this.underTimeSolveCount,
    required this.cleanSolveCount,
  });

  factory Question({
    int? id,
    required int courseId,
    required int position,
    required String prompt,
    required String topic,
    required _in2t4eqa.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    required int attemptCount,
    required int attemptedStudentCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      position: jsonSerialization['position'] as int,
      prompt: jsonSerialization['prompt'] as String,
      topic: jsonSerialization['topic'] as String,
      questionType: _in2t4eqa.QuestionType.fromJson(
        (jsonSerialization['questionType'] as String),
      ),
      points: jsonSerialization['points'] as int,
      expectedSeconds: jsonSerialization['expectedSeconds'] as int,
      topicNote: jsonSerialization['topicNote'] as String?,
      helpHint: jsonSerialization['helpHint'] as String?,
      attemptCount: jsonSerialization['attemptCount'] as int,
      attemptedStudentCount: jsonSerialization['attemptedStudentCount'] as int,
      solvedStudentCount: jsonSerialization['solvedStudentCount'] as int,
      firstTrySolveCount: jsonSerialization['firstTrySolveCount'] as int,
      underTimeSolveCount: jsonSerialization['underTimeSolveCount'] as int,
      cleanSolveCount: jsonSerialization['cleanSolveCount'] as int,
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
  int? id;

  int courseId;

  int position;

  String prompt;

  String topic;

  _in2t4eqa.QuestionType questionType;

  int points;

  int expectedSeconds;

  String? topicNote;

  String? helpHint;

  int attemptCount;

  int attemptedStudentCount;

  int solvedStudentCount;

  int firstTrySolveCount;

  int underTimeSolveCount;

  int cleanSolveCount;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Question copyWith({
    int? id,
    int? courseId,
    int? position,
    String? prompt,
    String? topic,
    _in2t4eqa.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    String? topicNote,
    String? helpHint,
    int? attemptCount,
    int? attemptedStudentCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'courseId': courseId,
      'position': position,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      'attemptCount': attemptCount,
      'attemptedStudentCount': attemptedStudentCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'courseId': courseId,
      'position': position,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      'attemptCount': attemptCount,
      'attemptedStudentCount': attemptedStudentCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
    };
  }

  static QuestionInclude include() {
    return QuestionInclude._();
  }

  static QuestionIncludeList includeList({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int courseId,
    required int position,
    required String prompt,
    required String topic,
    required _in2t4eqa.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    required int attemptCount,
    required int attemptedStudentCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
  }) : super._(
         id: id,
         courseId: courseId,
         position: position,
         prompt: prompt,
         topic: topic,
         questionType: questionType,
         points: points,
         expectedSeconds: expectedSeconds,
         topicNote: topicNote,
         helpHint: helpHint,
         attemptCount: attemptCount,
         attemptedStudentCount: attemptedStudentCount,
         solvedStudentCount: solvedStudentCount,
         firstTrySolveCount: firstTrySolveCount,
         underTimeSolveCount: underTimeSolveCount,
         cleanSolveCount: cleanSolveCount,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? position,
    String? prompt,
    String? topic,
    _in2t4eqa.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    Object? topicNote = _Undefined,
    Object? helpHint = _Undefined,
    int? attemptCount,
    int? attemptedStudentCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      position: position ?? this.position,
      prompt: prompt ?? this.prompt,
      topic: topic ?? this.topic,
      questionType: questionType ?? this.questionType,
      points: points ?? this.points,
      expectedSeconds: expectedSeconds ?? this.expectedSeconds,
      topicNote: topicNote is String? ? topicNote : this.topicNote,
      helpHint: helpHint is String? ? helpHint : this.helpHint,
      attemptCount: attemptCount ?? this.attemptCount,
      attemptedStudentCount:
          attemptedStudentCount ?? this.attemptedStudentCount,
      solvedStudentCount: solvedStudentCount ?? this.solvedStudentCount,
      firstTrySolveCount: firstTrySolveCount ?? this.firstTrySolveCount,
      underTimeSolveCount: underTimeSolveCount ?? this.underTimeSolveCount,
      cleanSolveCount: cleanSolveCount ?? this.cleanSolveCount,
    );
  }
}

class QuestionUpdateTable extends _is.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _is.ColumnValue<int, int> courseId(int value) => _is.ColumnValue(
    table.courseId,
    value,
  );

  _is.ColumnValue<int, int> position(int value) => _is.ColumnValue(
    table.position,
    value,
  );

  _is.ColumnValue<String, String> prompt(String value) => _is.ColumnValue(
    table.prompt,
    value,
  );

  _is.ColumnValue<String, String> topic(String value) => _is.ColumnValue(
    table.topic,
    value,
  );

  _is.ColumnValue<_in2t4eqa.QuestionType, _in2t4eqa.QuestionType> questionType(
    _in2t4eqa.QuestionType value,
  ) => _is.ColumnValue(
    table.questionType,
    value,
  );

  _is.ColumnValue<int, int> points(int value) => _is.ColumnValue(
    table.points,
    value,
  );

  _is.ColumnValue<int, int> expectedSeconds(int value) => _is.ColumnValue(
    table.expectedSeconds,
    value,
  );

  _is.ColumnValue<String, String> topicNote(String? value) => _is.ColumnValue(
    table.topicNote,
    value,
  );

  _is.ColumnValue<String, String> helpHint(String? value) => _is.ColumnValue(
    table.helpHint,
    value,
  );

  _is.ColumnValue<int, int> attemptCount(int value) => _is.ColumnValue(
    table.attemptCount,
    value,
  );

  _is.ColumnValue<int, int> attemptedStudentCount(int value) => _is.ColumnValue(
    table.attemptedStudentCount,
    value,
  );

  _is.ColumnValue<int, int> solvedStudentCount(int value) => _is.ColumnValue(
    table.solvedStudentCount,
    value,
  );

  _is.ColumnValue<int, int> firstTrySolveCount(int value) => _is.ColumnValue(
    table.firstTrySolveCount,
    value,
  );

  _is.ColumnValue<int, int> underTimeSolveCount(int value) => _is.ColumnValue(
    table.underTimeSolveCount,
    value,
  );

  _is.ColumnValue<int, int> cleanSolveCount(int value) => _is.ColumnValue(
    table.cleanSolveCount,
    value,
  );
}

class QuestionTable extends _is.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'question') {
    updateTable = QuestionUpdateTable(this);
    courseId = _is.ColumnInt(
      'courseId',
      this,
    );
    position = _is.ColumnInt(
      'position',
      this,
    );
    prompt = _is.ColumnString(
      'prompt',
      this,
    );
    topic = _is.ColumnString(
      'topic',
      this,
    );
    questionType = _is.ColumnEnum(
      'questionType',
      this,
      _is.EnumSerialization.byName,
    );
    points = _is.ColumnInt(
      'points',
      this,
    );
    expectedSeconds = _is.ColumnInt(
      'expectedSeconds',
      this,
    );
    topicNote = _is.ColumnString(
      'topicNote',
      this,
    );
    helpHint = _is.ColumnString(
      'helpHint',
      this,
    );
    attemptCount = _is.ColumnInt(
      'attemptCount',
      this,
    );
    attemptedStudentCount = _is.ColumnInt(
      'attemptedStudentCount',
      this,
    );
    solvedStudentCount = _is.ColumnInt(
      'solvedStudentCount',
      this,
    );
    firstTrySolveCount = _is.ColumnInt(
      'firstTrySolveCount',
      this,
    );
    underTimeSolveCount = _is.ColumnInt(
      'underTimeSolveCount',
      this,
    );
    cleanSolveCount = _is.ColumnInt(
      'cleanSolveCount',
      this,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _is.ColumnInt courseId;

  late final _is.ColumnInt position;

  late final _is.ColumnString prompt;

  late final _is.ColumnString topic;

  late final _is.ColumnEnum<_in2t4eqa.QuestionType> questionType;

  late final _is.ColumnInt points;

  late final _is.ColumnInt expectedSeconds;

  late final _is.ColumnString topicNote;

  late final _is.ColumnString helpHint;

  late final _is.ColumnInt attemptCount;

  late final _is.ColumnInt attemptedStudentCount;

  late final _is.ColumnInt solvedStudentCount;

  late final _is.ColumnInt firstTrySolveCount;

  late final _is.ColumnInt underTimeSolveCount;

  late final _is.ColumnInt cleanSolveCount;

  @override
  List<_is.Column> get columns => [
    id,
    courseId,
    position,
    prompt,
    topic,
    questionType,
    points,
    expectedSeconds,
    topicNote,
    helpHint,
    attemptCount,
    attemptedStudentCount,
    solvedStudentCount,
    firstTrySolveCount,
    underTimeSolveCount,
    cleanSolveCount,
  ];
}

class QuestionInclude extends _is.IncludeObject {
  QuestionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _is.IncludeList {
  QuestionIncludeList._({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Question>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Question?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> insert(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Question]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> upsert(
    _is.DatabaseSession session,
    List<Question> rows, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Question>(
      rows,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Question] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question?> upsertRow(
    _is.DatabaseSession session,
    Question row, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Question>(
      row,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> update(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _is.DatabaseSession session,
    Question row, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> delete(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Question>(
      rows,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
