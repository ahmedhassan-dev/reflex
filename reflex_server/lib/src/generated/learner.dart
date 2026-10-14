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
import 'enums/role.dart' as _iu4tij3a;

abstract class Learner
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Learner._({
    this.id,
    required this.authUserId,
    required this.displayName,
    required this.role,
    this.fcmToken,
  });

  factory Learner({
    int? id,
    required _is.UuidValue authUserId,
    required String displayName,
    required _iu4tij3a.Role role,
    String? fcmToken,
  }) = _LearnerImpl;

  factory Learner.fromJson(Map<String, dynamic> jsonSerialization) {
    return Learner(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      role: _iu4tij3a.Role.fromJson((jsonSerialization['role'] as String)),
      fcmToken: jsonSerialization['fcmToken'] as String?,
    );
  }

  static final t = LearnerTable();

  static const db = LearnerRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String displayName;

  _iu4tij3a.Role role;

  String? fcmToken;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Learner]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Learner copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? displayName,
    _iu4tij3a.Role? role,
    String? fcmToken,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Learner',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (fcmToken != null) 'fcmToken': fcmToken,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Learner',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (fcmToken != null) 'fcmToken': fcmToken,
    };
  }

  static LearnerInclude include() {
    return LearnerInclude._();
  }

  static LearnerIncludeList includeList({
    _is.WhereExpressionBuilder<LearnerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    LearnerInclude? include,
  }) {
    return LearnerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LearnerImpl extends Learner {
  _LearnerImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String displayName,
    required _iu4tij3a.Role role,
    String? fcmToken,
  }) : super._(
         id: id,
         authUserId: authUserId,
         displayName: displayName,
         role: role,
         fcmToken: fcmToken,
       );

  /// Returns a shallow copy of this [Learner]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Learner copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? displayName,
    _iu4tij3a.Role? role,
    Object? fcmToken = _Undefined,
  }) {
    return Learner(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      fcmToken: fcmToken is String? ? fcmToken : this.fcmToken,
    );
  }
}

class LearnerUpdateTable extends _is.UpdateTable<LearnerTable> {
  LearnerUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<_iu4tij3a.Role, _iu4tij3a.Role> role(_iu4tij3a.Role value) =>
      _is.ColumnValue(
        table.role,
        value,
      );

  _is.ColumnValue<String, String> fcmToken(String? value) => _is.ColumnValue(
    table.fcmToken,
    value,
  );
}

class LearnerTable extends _is.Table<int?> {
  LearnerTable({super.tableRelation}) : super(tableName: 'learner') {
    updateTable = LearnerUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    fcmToken = _is.ColumnString(
      'fcmToken',
      this,
    );
  }

  late final LearnerUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString displayName;

  late final _is.ColumnEnum<_iu4tij3a.Role> role;

  late final _is.ColumnString fcmToken;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    displayName,
    role,
    fcmToken,
  ];
}

class LearnerInclude extends _is.IncludeObject {
  LearnerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Learner.t;
}

class LearnerIncludeList extends _is.IncludeList {
  LearnerIncludeList._({
    _is.WhereExpressionBuilder<LearnerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Learner.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Learner.t;
}

class LearnerRepository {
  const LearnerRepository._();

  /// Returns a list of [Learner]s matching the given query parameters.
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
  Future<List<Learner>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Learner>(
      where: where?.call(Learner.t),
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Learner] matching the given query parameters.
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
  Future<Learner?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnerTable>? where,
    int? offset,
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Learner>(
      where: where?.call(Learner.t),
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Learner] by its [id] or null if no such row exists.
  Future<Learner?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Learner>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Learner]s in the list and returns the inserted rows.
  ///
  /// The returned [Learner]s will have their `id` fields set.
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
  Future<List<Learner>> insert(
    _is.DatabaseSession session,
    List<Learner> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Learner>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Learner] and returns the inserted row.
  ///
  /// The returned [Learner] will have its `id` field set.
  Future<Learner> insertRow(
    _is.DatabaseSession session,
    Learner row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Learner>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Learner]s in the list and returns the resulting rows.
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
  /// The returned [Learner]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Learner>> upsert(
    _is.DatabaseSession session,
    List<Learner> rows, {
    required _is.ColumnSelections<LearnerTable> conflictColumns,
    _is.ColumnSelections<LearnerTable>? updateColumns,
    _is.WhereExpressionBuilder<LearnerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Learner>(
      rows,
      conflictColumns: conflictColumns(Learner.t),
      updateColumns: updateColumns?.call(Learner.t),
      updateWhere: updateWhere?.call(Learner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Learner] and returns the resulting row.
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
  /// The returned [Learner] will have its `id` field set.
  Future<Learner?> upsertRow(
    _is.DatabaseSession session,
    Learner row, {
    required _is.ColumnSelections<LearnerTable> conflictColumns,
    _is.ColumnSelections<LearnerTable>? updateColumns,
    _is.WhereExpressionBuilder<LearnerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Learner>(
      row,
      conflictColumns: conflictColumns(Learner.t),
      updateColumns: updateColumns?.call(Learner.t),
      updateWhere: updateWhere?.call(Learner.t),
      transaction: transaction,
    );
  }

  /// Updates all [Learner]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Learner>> update(
    _is.DatabaseSession session,
    List<Learner> rows, {
    _is.ColumnSelections<LearnerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Learner>(
      rows,
      columns: columns?.call(Learner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Learner]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Learner> updateRow(
    _is.DatabaseSession session,
    Learner row, {
    _is.ColumnSelections<LearnerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Learner>(
      row,
      columns: columns?.call(Learner.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Learner] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Learner?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LearnerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Learner>(
      id,
      columnValues: columnValues(Learner.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Learner]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Learner>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LearnerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LearnerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Learner>(
      columnValues: columnValues(Learner.t.updateTable),
      where: where(Learner.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Learner]s in the list and returns the deleted rows.
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
  Future<List<Learner>> delete(
    _is.DatabaseSession session,
    List<Learner> rows, {
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Learner>(
      rows,
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Learner].
  Future<Learner> deleteRow(
    _is.DatabaseSession session,
    Learner row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Learner>(
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
  Future<List<Learner>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LearnerTable> where,
    _is.OrderByBuilder<LearnerTable>? orderBy,
    _is.OrderByListBuilder<LearnerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Learner>(
      where: where(Learner.t),
      orderBy: orderBy?.call(Learner.t),
      orderByList: orderByList?.call(Learner.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LearnerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Learner>(
      where: where?.call(Learner.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Learner] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LearnerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Learner>(
      where: where(Learner.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
