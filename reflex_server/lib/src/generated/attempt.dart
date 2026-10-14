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
import 'enums/attempt_status.dart' as _ir7impgi;
import 'enums/reflex_tier.dart' as _i8m78wq8;

abstract class Attempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Attempt._({
    this.id,
    required this.profileId,
    required this.questionId,
    this.selectedOptionId,
    this.answerText,
    required this.status,
    required this.responseMs,
    required this.usedHelp,
    required this.isFirstAttempt,
    required this.underExpectedTime,
    required this.isClean,
    required this.reflexTier,
    required this.createdAt,
  });

  factory Attempt({
    int? id,
    required int profileId,
    required int questionId,
    int? selectedOptionId,
    String? answerText,
    required _ir7impgi.AttemptStatus status,
    required int responseMs,
    required bool usedHelp,
    required bool isFirstAttempt,
    required bool underExpectedTime,
    required bool isClean,
    required _i8m78wq8.ReflexTier reflexTier,
    required DateTime createdAt,
  }) = _AttemptImpl;

  factory Attempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attempt(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      questionId: jsonSerialization['questionId'] as int,
      selectedOptionId: jsonSerialization['selectedOptionId'] as int?,
      answerText: jsonSerialization['answerText'] as String?,
      status: _ir7impgi.AttemptStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      responseMs: jsonSerialization['responseMs'] as int,
      usedHelp: _is.BoolJsonExtension.fromJson(jsonSerialization['usedHelp']),
      isFirstAttempt: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isFirstAttempt'],
      ),
      underExpectedTime: _is.BoolJsonExtension.fromJson(
        jsonSerialization['underExpectedTime'],
      ),
      isClean: _is.BoolJsonExtension.fromJson(jsonSerialization['isClean']),
      reflexTier: _i8m78wq8.ReflexTier.fromJson(
        (jsonSerialization['reflexTier'] as String),
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AttemptTable();

  static const db = AttemptRepository._();

  @override
  int? id;

  int profileId;

  int questionId;

  int? selectedOptionId;

  String? answerText;

  _ir7impgi.AttemptStatus status;

  int responseMs;

  bool usedHelp;

  bool isFirstAttempt;

  bool underExpectedTime;

  bool isClean;

  _i8m78wq8.ReflexTier reflexTier;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Attempt copyWith({
    int? id,
    int? profileId,
    int? questionId,
    int? selectedOptionId,
    String? answerText,
    _ir7impgi.AttemptStatus? status,
    int? responseMs,
    bool? usedHelp,
    bool? isFirstAttempt,
    bool? underExpectedTime,
    bool? isClean,
    _i8m78wq8.ReflexTier? reflexTier,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'profileId': profileId,
      'questionId': questionId,
      if (selectedOptionId != null) 'selectedOptionId': selectedOptionId,
      if (answerText != null) 'answerText': answerText,
      'status': status.toJson(),
      'responseMs': responseMs,
      'usedHelp': usedHelp,
      'isFirstAttempt': isFirstAttempt,
      'underExpectedTime': underExpectedTime,
      'isClean': isClean,
      'reflexTier': reflexTier.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'profileId': profileId,
      'questionId': questionId,
      if (selectedOptionId != null) 'selectedOptionId': selectedOptionId,
      if (answerText != null) 'answerText': answerText,
      'status': status.toJson(),
      'responseMs': responseMs,
      'usedHelp': usedHelp,
      'isFirstAttempt': isFirstAttempt,
      'underExpectedTime': underExpectedTime,
      'isClean': isClean,
      'reflexTier': reflexTier.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static AttemptInclude include() {
    return AttemptInclude._();
  }

  static AttemptIncludeList includeList({
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    AttemptInclude? include,
  }) {
    return AttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttemptImpl extends Attempt {
  _AttemptImpl({
    int? id,
    required int profileId,
    required int questionId,
    int? selectedOptionId,
    String? answerText,
    required _ir7impgi.AttemptStatus status,
    required int responseMs,
    required bool usedHelp,
    required bool isFirstAttempt,
    required bool underExpectedTime,
    required bool isClean,
    required _i8m78wq8.ReflexTier reflexTier,
    required DateTime createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         questionId: questionId,
         selectedOptionId: selectedOptionId,
         answerText: answerText,
         status: status,
         responseMs: responseMs,
         usedHelp: usedHelp,
         isFirstAttempt: isFirstAttempt,
         underExpectedTime: underExpectedTime,
         isClean: isClean,
         reflexTier: reflexTier,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Attempt copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? questionId,
    Object? selectedOptionId = _Undefined,
    Object? answerText = _Undefined,
    _ir7impgi.AttemptStatus? status,
    int? responseMs,
    bool? usedHelp,
    bool? isFirstAttempt,
    bool? underExpectedTime,
    bool? isClean,
    _i8m78wq8.ReflexTier? reflexTier,
    DateTime? createdAt,
  }) {
    return Attempt(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      questionId: questionId ?? this.questionId,
      selectedOptionId: selectedOptionId is int?
          ? selectedOptionId
          : this.selectedOptionId,
      answerText: answerText is String? ? answerText : this.answerText,
      status: status ?? this.status,
      responseMs: responseMs ?? this.responseMs,
      usedHelp: usedHelp ?? this.usedHelp,
      isFirstAttempt: isFirstAttempt ?? this.isFirstAttempt,
      underExpectedTime: underExpectedTime ?? this.underExpectedTime,
      isClean: isClean ?? this.isClean,
      reflexTier: reflexTier ?? this.reflexTier,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AttemptUpdateTable extends _is.UpdateTable<AttemptTable> {
  AttemptUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> questionId(int value) => _is.ColumnValue(
    table.questionId,
    value,
  );

  _is.ColumnValue<int, int> selectedOptionId(int? value) => _is.ColumnValue(
    table.selectedOptionId,
    value,
  );

  _is.ColumnValue<String, String> answerText(String? value) => _is.ColumnValue(
    table.answerText,
    value,
  );

  _is.ColumnValue<_ir7impgi.AttemptStatus, _ir7impgi.AttemptStatus> status(
    _ir7impgi.AttemptStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> responseMs(int value) => _is.ColumnValue(
    table.responseMs,
    value,
  );

  _is.ColumnValue<bool, bool> usedHelp(bool value) => _is.ColumnValue(
    table.usedHelp,
    value,
  );

  _is.ColumnValue<bool, bool> isFirstAttempt(bool value) => _is.ColumnValue(
    table.isFirstAttempt,
    value,
  );

  _is.ColumnValue<bool, bool> underExpectedTime(bool value) => _is.ColumnValue(
    table.underExpectedTime,
    value,
  );

  _is.ColumnValue<bool, bool> isClean(bool value) => _is.ColumnValue(
    table.isClean,
    value,
  );

  _is.ColumnValue<_i8m78wq8.ReflexTier, _i8m78wq8.ReflexTier> reflexTier(
    _i8m78wq8.ReflexTier value,
  ) => _is.ColumnValue(
    table.reflexTier,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AttemptTable extends _is.Table<int?> {
  AttemptTable({super.tableRelation}) : super(tableName: 'attempt') {
    updateTable = AttemptUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    questionId = _is.ColumnInt(
      'questionId',
      this,
    );
    selectedOptionId = _is.ColumnInt(
      'selectedOptionId',
      this,
    );
    answerText = _is.ColumnString(
      'answerText',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    responseMs = _is.ColumnInt(
      'responseMs',
      this,
    );
    usedHelp = _is.ColumnBool(
      'usedHelp',
      this,
    );
    isFirstAttempt = _is.ColumnBool(
      'isFirstAttempt',
      this,
    );
    underExpectedTime = _is.ColumnBool(
      'underExpectedTime',
      this,
    );
    isClean = _is.ColumnBool(
      'isClean',
      this,
    );
    reflexTier = _is.ColumnEnum(
      'reflexTier',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AttemptUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt questionId;

  late final _is.ColumnInt selectedOptionId;

  late final _is.ColumnString answerText;

  late final _is.ColumnEnum<_ir7impgi.AttemptStatus> status;

  late final _is.ColumnInt responseMs;

  late final _is.ColumnBool usedHelp;

  late final _is.ColumnBool isFirstAttempt;

  late final _is.ColumnBool underExpectedTime;

  late final _is.ColumnBool isClean;

  late final _is.ColumnEnum<_i8m78wq8.ReflexTier> reflexTier;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    questionId,
    selectedOptionId,
    answerText,
    status,
    responseMs,
    usedHelp,
    isFirstAttempt,
    underExpectedTime,
    isClean,
    reflexTier,
    createdAt,
  ];
}

class AttemptInclude extends _is.IncludeObject {
  AttemptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Attempt.t;
}

class AttemptIncludeList extends _is.IncludeList {
  AttemptIncludeList._({
    _is.WhereExpressionBuilder<AttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Attempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Attempt.t;
}

class AttemptRepository {
  const AttemptRepository._();

  /// Returns a list of [Attempt]s matching the given query parameters.
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
  Future<List<Attempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Attempt>(
      where: where?.call(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Attempt] matching the given query parameters.
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
  Future<Attempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Attempt>(
      where: where?.call(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Attempt] by its [id] or null if no such row exists.
  Future<Attempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Attempt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Attempt]s in the list and returns the inserted rows.
  ///
  /// The returned [Attempt]s will have their `id` fields set.
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
  Future<List<Attempt>> insert(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Attempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Attempt] and returns the inserted row.
  ///
  /// The returned [Attempt] will have its `id` field set.
  Future<Attempt> insertRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Attempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Attempt]s in the list and returns the resulting rows.
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
  /// The returned [Attempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> upsert(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    required _is.ColumnSelections<AttemptTable> conflictColumns,
    _is.ColumnSelections<AttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<AttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Attempt>(
      rows,
      conflictColumns: conflictColumns(Attempt.t),
      updateColumns: updateColumns?.call(Attempt.t),
      updateWhere: updateWhere?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Attempt] and returns the resulting row.
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
  /// The returned [Attempt] will have its `id` field set.
  Future<Attempt?> upsertRow(
    _is.DatabaseSession session,
    Attempt row, {
    required _is.ColumnSelections<AttemptTable> conflictColumns,
    _is.ColumnSelections<AttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<AttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Attempt>(
      row,
      conflictColumns: conflictColumns(Attempt.t),
      updateColumns: updateColumns?.call(Attempt.t),
      updateWhere: updateWhere?.call(Attempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [Attempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> update(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.ColumnSelections<AttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Attempt>(
      rows,
      columns: columns?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Attempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Attempt> updateRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.ColumnSelections<AttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Attempt>(
      row,
      columns: columns?.call(Attempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Attempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Attempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Attempt>(
      id,
      columnValues: columnValues(Attempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Attempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Attempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Attempt>(
      columnValues: columnValues(Attempt.t.updateTable),
      where: where(Attempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Attempt]s in the list and returns the deleted rows.
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
  Future<List<Attempt>> delete(
    _is.DatabaseSession session,
    List<Attempt> rows, {
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Attempt>(
      rows,
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Attempt].
  Future<Attempt> deleteRow(
    _is.DatabaseSession session,
    Attempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Attempt>(
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
  Future<List<Attempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttemptTable> where,
    _is.OrderByBuilder<AttemptTable>? orderBy,
    _is.OrderByListBuilder<AttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Attempt>(
      where: where(Attempt.t),
      orderBy: orderBy?.call(Attempt.t),
      orderByList: orderByList?.call(Attempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Attempt>(
      where: where?.call(Attempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Attempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Attempt>(
      where: where(Attempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
