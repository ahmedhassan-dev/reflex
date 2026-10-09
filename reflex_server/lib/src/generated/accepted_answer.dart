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

abstract class AcceptedAnswer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AcceptedAnswer._({
    this.id,
    required this.questionId,
    required this.normalizedText,
  });

  factory AcceptedAnswer({
    int? id,
    required int questionId,
    required String normalizedText,
  }) = _AcceptedAnswerImpl;

  factory AcceptedAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcceptedAnswer(
      id: jsonSerialization['id'] as int?,
      questionId: jsonSerialization['questionId'] as int,
      normalizedText: jsonSerialization['normalizedText'] as String,
    );
  }

  static final t = AcceptedAnswerTable();

  static const db = AcceptedAnswerRepository._();

  @override
  int? id;

  int questionId;

  String normalizedText;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AcceptedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AcceptedAnswer copyWith({
    int? id,
    int? questionId,
    String? normalizedText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcceptedAnswer',
      if (id != null) 'id': id,
      'questionId': questionId,
      'normalizedText': normalizedText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcceptedAnswer',
      if (id != null) 'id': id,
      'questionId': questionId,
      'normalizedText': normalizedText,
    };
  }

  static AcceptedAnswerInclude include() {
    return AcceptedAnswerInclude._();
  }

  static AcceptedAnswerIncludeList includeList({
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    AcceptedAnswerInclude? include,
  }) {
    return AcceptedAnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcceptedAnswerImpl extends AcceptedAnswer {
  _AcceptedAnswerImpl({
    int? id,
    required int questionId,
    required String normalizedText,
  }) : super._(
         id: id,
         questionId: questionId,
         normalizedText: normalizedText,
       );

  /// Returns a shallow copy of this [AcceptedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AcceptedAnswer copyWith({
    Object? id = _Undefined,
    int? questionId,
    String? normalizedText,
  }) {
    return AcceptedAnswer(
      id: id is int? ? id : this.id,
      questionId: questionId ?? this.questionId,
      normalizedText: normalizedText ?? this.normalizedText,
    );
  }
}

class AcceptedAnswerUpdateTable extends _is.UpdateTable<AcceptedAnswerTable> {
  AcceptedAnswerUpdateTable(super.table);

  _is.ColumnValue<int, int> questionId(int value) => _is.ColumnValue(
    table.questionId,
    value,
  );

  _is.ColumnValue<String, String> normalizedText(String value) =>
      _is.ColumnValue(
        table.normalizedText,
        value,
      );
}

class AcceptedAnswerTable extends _is.Table<int?> {
  AcceptedAnswerTable({super.tableRelation})
    : super(tableName: 'accepted_answer') {
    updateTable = AcceptedAnswerUpdateTable(this);
    questionId = _is.ColumnInt(
      'questionId',
      this,
    );
    normalizedText = _is.ColumnString(
      'normalizedText',
      this,
    );
  }

  late final AcceptedAnswerUpdateTable updateTable;

  late final _is.ColumnInt questionId;

  late final _is.ColumnString normalizedText;

  @override
  List<_is.Column> get columns => [
    id,
    questionId,
    normalizedText,
  ];
}

class AcceptedAnswerInclude extends _is.IncludeObject {
  AcceptedAnswerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AcceptedAnswer.t;
}

class AcceptedAnswerIncludeList extends _is.IncludeList {
  AcceptedAnswerIncludeList._({
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AcceptedAnswer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AcceptedAnswer.t;
}

class AcceptedAnswerRepository {
  const AcceptedAnswerRepository._();

  /// Returns a list of [AcceptedAnswer]s matching the given query parameters.
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
  Future<List<AcceptedAnswer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AcceptedAnswer>(
      where: where?.call(AcceptedAnswer.t),
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AcceptedAnswer] matching the given query parameters.
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
  Future<AcceptedAnswer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? where,
    int? offset,
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AcceptedAnswer>(
      where: where?.call(AcceptedAnswer.t),
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AcceptedAnswer] by its [id] or null if no such row exists.
  Future<AcceptedAnswer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AcceptedAnswer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AcceptedAnswer]s in the list and returns the inserted rows.
  ///
  /// The returned [AcceptedAnswer]s will have their `id` fields set.
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
  Future<List<AcceptedAnswer>> insert(
    _is.DatabaseSession session,
    List<AcceptedAnswer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AcceptedAnswer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AcceptedAnswer] and returns the inserted row.
  ///
  /// The returned [AcceptedAnswer] will have its `id` field set.
  Future<AcceptedAnswer> insertRow(
    _is.DatabaseSession session,
    AcceptedAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AcceptedAnswer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AcceptedAnswer]s in the list and returns the resulting rows.
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
  /// The returned [AcceptedAnswer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcceptedAnswer>> upsert(
    _is.DatabaseSession session,
    List<AcceptedAnswer> rows, {
    required _is.ColumnSelections<AcceptedAnswerTable> conflictColumns,
    _is.ColumnSelections<AcceptedAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AcceptedAnswer>(
      rows,
      conflictColumns: conflictColumns(AcceptedAnswer.t),
      updateColumns: updateColumns?.call(AcceptedAnswer.t),
      updateWhere: updateWhere?.call(AcceptedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AcceptedAnswer] and returns the resulting row.
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
  /// The returned [AcceptedAnswer] will have its `id` field set.
  Future<AcceptedAnswer?> upsertRow(
    _is.DatabaseSession session,
    AcceptedAnswer row, {
    required _is.ColumnSelections<AcceptedAnswerTable> conflictColumns,
    _is.ColumnSelections<AcceptedAnswerTable>? updateColumns,
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AcceptedAnswer>(
      row,
      conflictColumns: conflictColumns(AcceptedAnswer.t),
      updateColumns: updateColumns?.call(AcceptedAnswer.t),
      updateWhere: updateWhere?.call(AcceptedAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates all [AcceptedAnswer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcceptedAnswer>> update(
    _is.DatabaseSession session,
    List<AcceptedAnswer> rows, {
    _is.ColumnSelections<AcceptedAnswerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AcceptedAnswer>(
      rows,
      columns: columns?.call(AcceptedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AcceptedAnswer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AcceptedAnswer> updateRow(
    _is.DatabaseSession session,
    AcceptedAnswer row, {
    _is.ColumnSelections<AcceptedAnswerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AcceptedAnswer>(
      row,
      columns: columns?.call(AcceptedAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcceptedAnswer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AcceptedAnswer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AcceptedAnswerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AcceptedAnswer>(
      id,
      columnValues: columnValues(AcceptedAnswer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AcceptedAnswer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AcceptedAnswer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AcceptedAnswerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AcceptedAnswerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AcceptedAnswer>(
      columnValues: columnValues(AcceptedAnswer.t.updateTable),
      where: where(AcceptedAnswer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AcceptedAnswer]s in the list and returns the deleted rows.
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
  Future<List<AcceptedAnswer>> delete(
    _is.DatabaseSession session,
    List<AcceptedAnswer> rows, {
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AcceptedAnswer>(
      rows,
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AcceptedAnswer].
  Future<AcceptedAnswer> deleteRow(
    _is.DatabaseSession session,
    AcceptedAnswer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AcceptedAnswer>(
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
  Future<List<AcceptedAnswer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AcceptedAnswerTable> where,
    _is.OrderByBuilder<AcceptedAnswerTable>? orderBy,
    _is.OrderByListBuilder<AcceptedAnswerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AcceptedAnswer>(
      where: where(AcceptedAnswer.t),
      orderBy: orderBy?.call(AcceptedAnswer.t),
      orderByList: orderByList?.call(AcceptedAnswer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AcceptedAnswerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AcceptedAnswer>(
      where: where?.call(AcceptedAnswer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AcceptedAnswer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AcceptedAnswerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AcceptedAnswer>(
      where: where(AcceptedAnswer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
