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

abstract class ReviewState
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ReviewState._({
    this.id,
    required this.profileId,
    required this.questionId,
    required this.dueAt,
    required this.intervalDays,
    required this.lapses,
    required this.helpUsed,
    this.lastServedAt,
    this.lastResult,
  });

  factory ReviewState({
    int? id,
    required int profileId,
    required int questionId,
    required DateTime dueAt,
    required int intervalDays,
    required int lapses,
    required bool helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  }) = _ReviewStateImpl;

  factory ReviewState.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReviewState(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      questionId: jsonSerialization['questionId'] as int,
      dueAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      intervalDays: jsonSerialization['intervalDays'] as int,
      lapses: jsonSerialization['lapses'] as int,
      helpUsed: _is.BoolJsonExtension.fromJson(jsonSerialization['helpUsed']),
      lastServedAt: jsonSerialization['lastServedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastServedAt'],
            ),
      lastResult: jsonSerialization['lastResult'] == null
          ? null
          : _ir7impgi.AttemptStatus.fromJson(
              (jsonSerialization['lastResult'] as String),
            ),
    );
  }

  static final t = ReviewStateTable();

  static const db = ReviewStateRepository._();

  @override
  int? id;

  int profileId;

  int questionId;

  DateTime dueAt;

  int intervalDays;

  int lapses;

  bool helpUsed;

  DateTime? lastServedAt;

  _ir7impgi.AttemptStatus? lastResult;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReviewState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReviewState copyWith({
    int? id,
    int? profileId,
    int? questionId,
    DateTime? dueAt,
    int? intervalDays,
    int? lapses,
    bool? helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReviewState',
      if (id != null) 'id': id,
      'profileId': profileId,
      'questionId': questionId,
      'dueAt': dueAt.toJson(),
      'intervalDays': intervalDays,
      'lapses': lapses,
      'helpUsed': helpUsed,
      if (lastServedAt != null) 'lastServedAt': lastServedAt?.toJson(),
      if (lastResult != null) 'lastResult': lastResult?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReviewState',
      if (id != null) 'id': id,
      'profileId': profileId,
      'questionId': questionId,
      'dueAt': dueAt.toJson(),
      'intervalDays': intervalDays,
      'lapses': lapses,
      'helpUsed': helpUsed,
      if (lastServedAt != null) 'lastServedAt': lastServedAt?.toJson(),
      if (lastResult != null) 'lastResult': lastResult?.toJson(),
    };
  }

  static ReviewStateInclude include() {
    return ReviewStateInclude._();
  }

  static ReviewStateIncludeList includeList({
    _is.WhereExpressionBuilder<ReviewStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    ReviewStateInclude? include,
  }) {
    return ReviewStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReviewStateImpl extends ReviewState {
  _ReviewStateImpl({
    int? id,
    required int profileId,
    required int questionId,
    required DateTime dueAt,
    required int intervalDays,
    required int lapses,
    required bool helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  }) : super._(
         id: id,
         profileId: profileId,
         questionId: questionId,
         dueAt: dueAt,
         intervalDays: intervalDays,
         lapses: lapses,
         helpUsed: helpUsed,
         lastServedAt: lastServedAt,
         lastResult: lastResult,
       );

  /// Returns a shallow copy of this [ReviewState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReviewState copyWith({
    Object? id = _Undefined,
    int? profileId,
    int? questionId,
    DateTime? dueAt,
    int? intervalDays,
    int? lapses,
    bool? helpUsed,
    Object? lastServedAt = _Undefined,
    Object? lastResult = _Undefined,
  }) {
    return ReviewState(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      questionId: questionId ?? this.questionId,
      dueAt: dueAt ?? this.dueAt,
      intervalDays: intervalDays ?? this.intervalDays,
      lapses: lapses ?? this.lapses,
      helpUsed: helpUsed ?? this.helpUsed,
      lastServedAt: lastServedAt is DateTime?
          ? lastServedAt
          : this.lastServedAt,
      lastResult: lastResult is _ir7impgi.AttemptStatus?
          ? lastResult
          : this.lastResult,
    );
  }
}

class ReviewStateUpdateTable extends _is.UpdateTable<ReviewStateTable> {
  ReviewStateUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<int, int> questionId(int value) => _is.ColumnValue(
    table.questionId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dueAt(DateTime value) => _is.ColumnValue(
    table.dueAt,
    value,
  );

  _is.ColumnValue<int, int> intervalDays(int value) => _is.ColumnValue(
    table.intervalDays,
    value,
  );

  _is.ColumnValue<int, int> lapses(int value) => _is.ColumnValue(
    table.lapses,
    value,
  );

  _is.ColumnValue<bool, bool> helpUsed(bool value) => _is.ColumnValue(
    table.helpUsed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastServedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastServedAt,
        value,
      );

  _is.ColumnValue<_ir7impgi.AttemptStatus, _ir7impgi.AttemptStatus> lastResult(
    _ir7impgi.AttemptStatus? value,
  ) => _is.ColumnValue(
    table.lastResult,
    value,
  );
}

class ReviewStateTable extends _is.Table<int?> {
  ReviewStateTable({super.tableRelation}) : super(tableName: 'review_state') {
    updateTable = ReviewStateUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    questionId = _is.ColumnInt(
      'questionId',
      this,
    );
    dueAt = _is.ColumnDateTime(
      'dueAt',
      this,
    );
    intervalDays = _is.ColumnInt(
      'intervalDays',
      this,
    );
    lapses = _is.ColumnInt(
      'lapses',
      this,
    );
    helpUsed = _is.ColumnBool(
      'helpUsed',
      this,
    );
    lastServedAt = _is.ColumnDateTime(
      'lastServedAt',
      this,
    );
    lastResult = _is.ColumnEnum(
      'lastResult',
      this,
      _is.EnumSerialization.byName,
    );
  }

  late final ReviewStateUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  late final _is.ColumnInt questionId;

  late final _is.ColumnDateTime dueAt;

  late final _is.ColumnInt intervalDays;

  late final _is.ColumnInt lapses;

  late final _is.ColumnBool helpUsed;

  late final _is.ColumnDateTime lastServedAt;

  late final _is.ColumnEnum<_ir7impgi.AttemptStatus> lastResult;

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    questionId,
    dueAt,
    intervalDays,
    lapses,
    helpUsed,
    lastServedAt,
    lastResult,
  ];
}

class ReviewStateInclude extends _is.IncludeObject {
  ReviewStateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReviewState.t;
}

class ReviewStateIncludeList extends _is.IncludeList {
  ReviewStateIncludeList._({
    _is.WhereExpressionBuilder<ReviewStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReviewState.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReviewState.t;
}

class ReviewStateRepository {
  const ReviewStateRepository._();

  /// Returns a list of [ReviewState]s matching the given query parameters.
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
  Future<List<ReviewState>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReviewStateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReviewState>(
      where: where?.call(ReviewState.t),
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReviewState] matching the given query parameters.
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
  Future<ReviewState?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReviewStateTable>? where,
    int? offset,
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReviewState>(
      where: where?.call(ReviewState.t),
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReviewState] by its [id] or null if no such row exists.
  Future<ReviewState?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReviewState>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReviewState]s in the list and returns the inserted rows.
  ///
  /// The returned [ReviewState]s will have their `id` fields set.
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
  Future<List<ReviewState>> insert(
    _is.DatabaseSession session,
    List<ReviewState> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReviewState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReviewState] and returns the inserted row.
  ///
  /// The returned [ReviewState] will have its `id` field set.
  Future<ReviewState> insertRow(
    _is.DatabaseSession session,
    ReviewState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReviewState>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReviewState]s in the list and returns the resulting rows.
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
  /// The returned [ReviewState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReviewState>> upsert(
    _is.DatabaseSession session,
    List<ReviewState> rows, {
    required _is.ColumnSelections<ReviewStateTable> conflictColumns,
    _is.ColumnSelections<ReviewStateTable>? updateColumns,
    _is.WhereExpressionBuilder<ReviewStateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReviewState>(
      rows,
      conflictColumns: conflictColumns(ReviewState.t),
      updateColumns: updateColumns?.call(ReviewState.t),
      updateWhere: updateWhere?.call(ReviewState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReviewState] and returns the resulting row.
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
  /// The returned [ReviewState] will have its `id` field set.
  Future<ReviewState?> upsertRow(
    _is.DatabaseSession session,
    ReviewState row, {
    required _is.ColumnSelections<ReviewStateTable> conflictColumns,
    _is.ColumnSelections<ReviewStateTable>? updateColumns,
    _is.WhereExpressionBuilder<ReviewStateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReviewState>(
      row,
      conflictColumns: conflictColumns(ReviewState.t),
      updateColumns: updateColumns?.call(ReviewState.t),
      updateWhere: updateWhere?.call(ReviewState.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReviewState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReviewState>> update(
    _is.DatabaseSession session,
    List<ReviewState> rows, {
    _is.ColumnSelections<ReviewStateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReviewState>(
      rows,
      columns: columns?.call(ReviewState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReviewState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReviewState> updateRow(
    _is.DatabaseSession session,
    ReviewState row, {
    _is.ColumnSelections<ReviewStateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReviewState>(
      row,
      columns: columns?.call(ReviewState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReviewState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReviewState?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReviewStateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReviewState>(
      id,
      columnValues: columnValues(ReviewState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReviewState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReviewState>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReviewStateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReviewStateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReviewState>(
      columnValues: columnValues(ReviewState.t.updateTable),
      where: where(ReviewState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReviewState]s in the list and returns the deleted rows.
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
  Future<List<ReviewState>> delete(
    _is.DatabaseSession session,
    List<ReviewState> rows, {
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReviewState>(
      rows,
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReviewState].
  Future<ReviewState> deleteRow(
    _is.DatabaseSession session,
    ReviewState row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReviewState>(
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
  Future<List<ReviewState>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReviewStateTable> where,
    _is.OrderByBuilder<ReviewStateTable>? orderBy,
    _is.OrderByListBuilder<ReviewStateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReviewState>(
      where: where(ReviewState.t),
      orderBy: orderBy?.call(ReviewState.t),
      orderByList: orderByList?.call(ReviewState.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReviewStateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReviewState>(
      where: where?.call(ReviewState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReviewState] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReviewStateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReviewState>(
      where: where(ReviewState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
