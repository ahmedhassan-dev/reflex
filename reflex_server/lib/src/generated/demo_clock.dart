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

abstract class DemoClock
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DemoClock._({
    this.id,
    required this.offsetDays,
  });

  factory DemoClock({
    int? id,
    required int offsetDays,
  }) = _DemoClockImpl;

  factory DemoClock.fromJson(Map<String, dynamic> jsonSerialization) {
    return DemoClock(
      id: jsonSerialization['id'] as int?,
      offsetDays: jsonSerialization['offsetDays'] as int,
    );
  }

  static final t = DemoClockTable();

  static const db = DemoClockRepository._();

  @override
  int? id;

  int offsetDays;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DemoClock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DemoClock copyWith({
    int? id,
    int? offsetDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DemoClock',
      if (id != null) 'id': id,
      'offsetDays': offsetDays,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DemoClock',
      if (id != null) 'id': id,
      'offsetDays': offsetDays,
    };
  }

  static DemoClockInclude include() {
    return DemoClockInclude._();
  }

  static DemoClockIncludeList includeList({
    _is.WhereExpressionBuilder<DemoClockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    DemoClockInclude? include,
  }) {
    return DemoClockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DemoClockImpl extends DemoClock {
  _DemoClockImpl({
    int? id,
    required int offsetDays,
  }) : super._(
         id: id,
         offsetDays: offsetDays,
       );

  /// Returns a shallow copy of this [DemoClock]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DemoClock copyWith({
    Object? id = _Undefined,
    int? offsetDays,
  }) {
    return DemoClock(
      id: id is int? ? id : this.id,
      offsetDays: offsetDays ?? this.offsetDays,
    );
  }
}

class DemoClockUpdateTable extends _is.UpdateTable<DemoClockTable> {
  DemoClockUpdateTable(super.table);

  _is.ColumnValue<int, int> offsetDays(int value) => _is.ColumnValue(
    table.offsetDays,
    value,
  );
}

class DemoClockTable extends _is.Table<int?> {
  DemoClockTable({super.tableRelation}) : super(tableName: 'demo_clock') {
    updateTable = DemoClockUpdateTable(this);
    offsetDays = _is.ColumnInt(
      'offsetDays',
      this,
    );
  }

  late final DemoClockUpdateTable updateTable;

  late final _is.ColumnInt offsetDays;

  @override
  List<_is.Column> get columns => [
    id,
    offsetDays,
  ];
}

class DemoClockInclude extends _is.IncludeObject {
  DemoClockInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DemoClock.t;
}

class DemoClockIncludeList extends _is.IncludeList {
  DemoClockIncludeList._({
    _is.WhereExpressionBuilder<DemoClockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DemoClock.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DemoClock.t;
}

class DemoClockRepository {
  const DemoClockRepository._();

  /// Returns a list of [DemoClock]s matching the given query parameters.
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
  Future<List<DemoClock>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DemoClockTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DemoClock>(
      where: where?.call(DemoClock.t),
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DemoClock] matching the given query parameters.
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
  Future<DemoClock?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DemoClockTable>? where,
    int? offset,
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DemoClock>(
      where: where?.call(DemoClock.t),
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DemoClock] by its [id] or null if no such row exists.
  Future<DemoClock?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DemoClock>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DemoClock]s in the list and returns the inserted rows.
  ///
  /// The returned [DemoClock]s will have their `id` fields set.
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
  Future<List<DemoClock>> insert(
    _is.DatabaseSession session,
    List<DemoClock> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DemoClock>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DemoClock] and returns the inserted row.
  ///
  /// The returned [DemoClock] will have its `id` field set.
  Future<DemoClock> insertRow(
    _is.DatabaseSession session,
    DemoClock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DemoClock>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DemoClock]s in the list and returns the resulting rows.
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
  /// The returned [DemoClock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DemoClock>> upsert(
    _is.DatabaseSession session,
    List<DemoClock> rows, {
    required _is.ColumnSelections<DemoClockTable> conflictColumns,
    _is.ColumnSelections<DemoClockTable>? updateColumns,
    _is.WhereExpressionBuilder<DemoClockTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DemoClock>(
      rows,
      conflictColumns: conflictColumns(DemoClock.t),
      updateColumns: updateColumns?.call(DemoClock.t),
      updateWhere: updateWhere?.call(DemoClock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DemoClock] and returns the resulting row.
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
  /// The returned [DemoClock] will have its `id` field set.
  Future<DemoClock?> upsertRow(
    _is.DatabaseSession session,
    DemoClock row, {
    required _is.ColumnSelections<DemoClockTable> conflictColumns,
    _is.ColumnSelections<DemoClockTable>? updateColumns,
    _is.WhereExpressionBuilder<DemoClockTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DemoClock>(
      row,
      conflictColumns: conflictColumns(DemoClock.t),
      updateColumns: updateColumns?.call(DemoClock.t),
      updateWhere: updateWhere?.call(DemoClock.t),
      transaction: transaction,
    );
  }

  /// Updates all [DemoClock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DemoClock>> update(
    _is.DatabaseSession session,
    List<DemoClock> rows, {
    _is.ColumnSelections<DemoClockTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DemoClock>(
      rows,
      columns: columns?.call(DemoClock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DemoClock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DemoClock> updateRow(
    _is.DatabaseSession session,
    DemoClock row, {
    _is.ColumnSelections<DemoClockTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DemoClock>(
      row,
      columns: columns?.call(DemoClock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DemoClock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DemoClock?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DemoClockUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DemoClock>(
      id,
      columnValues: columnValues(DemoClock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DemoClock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DemoClock>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DemoClockUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DemoClockTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DemoClock>(
      columnValues: columnValues(DemoClock.t.updateTable),
      where: where(DemoClock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DemoClock]s in the list and returns the deleted rows.
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
  Future<List<DemoClock>> delete(
    _is.DatabaseSession session,
    List<DemoClock> rows, {
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DemoClock>(
      rows,
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DemoClock].
  Future<DemoClock> deleteRow(
    _is.DatabaseSession session,
    DemoClock row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DemoClock>(
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
  Future<List<DemoClock>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DemoClockTable> where,
    _is.OrderByBuilder<DemoClockTable>? orderBy,
    _is.OrderByListBuilder<DemoClockTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DemoClock>(
      where: where(DemoClock.t),
      orderBy: orderBy?.call(DemoClock.t),
      orderByList: orderByList?.call(DemoClock.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DemoClockTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DemoClock>(
      where: where?.call(DemoClock.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DemoClock] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DemoClockTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DemoClock>(
      where: where(DemoClock.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
