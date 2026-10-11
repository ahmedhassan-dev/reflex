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
import 'enums/subscription_status.dart' as _i5d9goyo;

abstract class CourseSubscription
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CourseSubscription._({
    this.id,
    required this.courseId,
    required this.studentId,
    required this.status,
    required this.requestedAt,
    this.decidedAt,
  });

  factory CourseSubscription({
    int? id,
    required int courseId,
    required int studentId,
    required _i5d9goyo.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) = _CourseSubscriptionImpl;

  factory CourseSubscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSubscription(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      status: _i5d9goyo.SubscriptionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      requestedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['requestedAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = CourseSubscriptionTable();

  static const db = CourseSubscriptionRepository._();

  @override
  int? id;

  int courseId;

  int studentId;

  _i5d9goyo.SubscriptionStatus status;

  DateTime requestedAt;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CourseSubscription]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CourseSubscription copyWith({
    int? id,
    int? courseId,
    int? studentId,
    _i5d9goyo.SubscriptionStatus? status,
    DateTime? requestedAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSubscription',
      if (id != null) 'id': id,
      'courseId': courseId,
      'studentId': studentId,
      'status': status.toJson(),
      'requestedAt': requestedAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseSubscription',
      if (id != null) 'id': id,
      'courseId': courseId,
      'studentId': studentId,
      'status': status.toJson(),
      'requestedAt': requestedAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  static CourseSubscriptionInclude include() {
    return CourseSubscriptionInclude._();
  }

  static CourseSubscriptionIncludeList includeList({
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    CourseSubscriptionInclude? include,
  }) {
    return CourseSubscriptionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseSubscriptionImpl extends CourseSubscription {
  _CourseSubscriptionImpl({
    int? id,
    required int courseId,
    required int studentId,
    required _i5d9goyo.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         studentId: studentId,
         status: status,
         requestedAt: requestedAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [CourseSubscription]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CourseSubscription copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? studentId,
    _i5d9goyo.SubscriptionStatus? status,
    DateTime? requestedAt,
    Object? decidedAt = _Undefined,
  }) {
    return CourseSubscription(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class CourseSubscriptionUpdateTable
    extends _is.UpdateTable<CourseSubscriptionTable> {
  CourseSubscriptionUpdateTable(super.table);

  _is.ColumnValue<int, int> courseId(int value) => _is.ColumnValue(
    table.courseId,
    value,
  );

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<_i5d9goyo.SubscriptionStatus, _i5d9goyo.SubscriptionStatus>
  status(_i5d9goyo.SubscriptionStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> requestedAt(DateTime value) =>
      _is.ColumnValue(
        table.requestedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class CourseSubscriptionTable extends _is.Table<int?> {
  CourseSubscriptionTable({super.tableRelation})
    : super(tableName: 'course_subscription') {
    updateTable = CourseSubscriptionUpdateTable(this);
    courseId = _is.ColumnInt(
      'courseId',
      this,
    );
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    requestedAt = _is.ColumnDateTime(
      'requestedAt',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final CourseSubscriptionUpdateTable updateTable;

  late final _is.ColumnInt courseId;

  late final _is.ColumnInt studentId;

  late final _is.ColumnEnum<_i5d9goyo.SubscriptionStatus> status;

  late final _is.ColumnDateTime requestedAt;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    courseId,
    studentId,
    status,
    requestedAt,
    decidedAt,
  ];
}

class CourseSubscriptionInclude extends _is.IncludeObject {
  CourseSubscriptionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CourseSubscription.t;
}

class CourseSubscriptionIncludeList extends _is.IncludeList {
  CourseSubscriptionIncludeList._({
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CourseSubscription.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CourseSubscription.t;
}

class CourseSubscriptionRepository {
  const CourseSubscriptionRepository._();

  /// Returns a list of [CourseSubscription]s matching the given query parameters.
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
  Future<List<CourseSubscription>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CourseSubscription>(
      where: where?.call(CourseSubscription.t),
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CourseSubscription] matching the given query parameters.
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
  Future<CourseSubscription?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? where,
    int? offset,
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CourseSubscription>(
      where: where?.call(CourseSubscription.t),
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CourseSubscription] by its [id] or null if no such row exists.
  Future<CourseSubscription?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CourseSubscription>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CourseSubscription]s in the list and returns the inserted rows.
  ///
  /// The returned [CourseSubscription]s will have their `id` fields set.
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
  Future<List<CourseSubscription>> insert(
    _is.DatabaseSession session,
    List<CourseSubscription> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CourseSubscription>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CourseSubscription] and returns the inserted row.
  ///
  /// The returned [CourseSubscription] will have its `id` field set.
  Future<CourseSubscription> insertRow(
    _is.DatabaseSession session,
    CourseSubscription row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CourseSubscription>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CourseSubscription]s in the list and returns the resulting rows.
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
  /// The returned [CourseSubscription]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CourseSubscription>> upsert(
    _is.DatabaseSession session,
    List<CourseSubscription> rows, {
    required _is.ColumnSelections<CourseSubscriptionTable> conflictColumns,
    _is.ColumnSelections<CourseSubscriptionTable>? updateColumns,
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CourseSubscription>(
      rows,
      conflictColumns: conflictColumns(CourseSubscription.t),
      updateColumns: updateColumns?.call(CourseSubscription.t),
      updateWhere: updateWhere?.call(CourseSubscription.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CourseSubscription] and returns the resulting row.
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
  /// The returned [CourseSubscription] will have its `id` field set.
  Future<CourseSubscription?> upsertRow(
    _is.DatabaseSession session,
    CourseSubscription row, {
    required _is.ColumnSelections<CourseSubscriptionTable> conflictColumns,
    _is.ColumnSelections<CourseSubscriptionTable>? updateColumns,
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CourseSubscription>(
      row,
      conflictColumns: conflictColumns(CourseSubscription.t),
      updateColumns: updateColumns?.call(CourseSubscription.t),
      updateWhere: updateWhere?.call(CourseSubscription.t),
      transaction: transaction,
    );
  }

  /// Updates all [CourseSubscription]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CourseSubscription>> update(
    _is.DatabaseSession session,
    List<CourseSubscription> rows, {
    _is.ColumnSelections<CourseSubscriptionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CourseSubscription>(
      rows,
      columns: columns?.call(CourseSubscription.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CourseSubscription]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CourseSubscription> updateRow(
    _is.DatabaseSession session,
    CourseSubscription row, {
    _is.ColumnSelections<CourseSubscriptionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CourseSubscription>(
      row,
      columns: columns?.call(CourseSubscription.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CourseSubscription] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CourseSubscription?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CourseSubscriptionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CourseSubscription>(
      id,
      columnValues: columnValues(CourseSubscription.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CourseSubscription]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CourseSubscription>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CourseSubscriptionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CourseSubscriptionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CourseSubscription>(
      columnValues: columnValues(CourseSubscription.t.updateTable),
      where: where(CourseSubscription.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CourseSubscription]s in the list and returns the deleted rows.
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
  Future<List<CourseSubscription>> delete(
    _is.DatabaseSession session,
    List<CourseSubscription> rows, {
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CourseSubscription>(
      rows,
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CourseSubscription].
  Future<CourseSubscription> deleteRow(
    _is.DatabaseSession session,
    CourseSubscription row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CourseSubscription>(
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
  Future<List<CourseSubscription>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CourseSubscriptionTable> where,
    _is.OrderByBuilder<CourseSubscriptionTable>? orderBy,
    _is.OrderByListBuilder<CourseSubscriptionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CourseSubscription>(
      where: where(CourseSubscription.t),
      orderBy: orderBy?.call(CourseSubscription.t),
      orderByList: orderByList?.call(CourseSubscription.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseSubscriptionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CourseSubscription>(
      where: where?.call(CourseSubscription.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CourseSubscription] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CourseSubscriptionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CourseSubscription>(
      where: where(CourseSubscription.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
