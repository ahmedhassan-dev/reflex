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
import 'package:reflex_server/src/generated/protocol.dart' as _immqfr35;
import 'package:serverpod/serverpod.dart' as _is;

abstract class Course implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Course._({
    this.id,
    required this.title,
    required this.subject,
    this.topics,
    this.teacherId,
    this.teacherName,
    this.isPublic,
  });

  factory Course({
    int? id,
    required String title,
    required String subject,
    List<String>? topics,
    int? teacherId,
    String? teacherName,
    bool? isPublic,
  }) = _CourseImpl;

  factory Course.fromJson(Map<String, dynamic> jsonSerialization) {
    return Course(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      subject: jsonSerialization['subject'] as String,
      topics: jsonSerialization['topics'] == null
          ? null
          : _immqfr35.Protocol().deserialize<List<String>>(
              jsonSerialization['topics'],
            ),
      teacherId: jsonSerialization['teacherId'] as int?,
      teacherName: jsonSerialization['teacherName'] as String?,
      isPublic: jsonSerialization['isPublic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
    );
  }

  static final t = CourseTable();

  static const db = CourseRepository._();

  @override
  int? id;

  String title;

  String subject;

  List<String>? topics;

  int? teacherId;

  String? teacherName;

  bool? isPublic;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Course copyWith({
    int? id,
    String? title,
    String? subject,
    List<String>? topics,
    int? teacherId,
    String? teacherName,
    bool? isPublic,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      'subject': subject,
      if (topics != null) 'topics': topics?.toJson(),
      if (teacherId != null) 'teacherId': teacherId,
      if (teacherName != null) 'teacherName': teacherName,
      if (isPublic != null) 'isPublic': isPublic,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      'subject': subject,
      if (topics != null) 'topics': topics?.toJson(),
      if (teacherId != null) 'teacherId': teacherId,
      if (teacherName != null) 'teacherName': teacherName,
      if (isPublic != null) 'isPublic': isPublic,
    };
  }

  static CourseInclude include() {
    return CourseInclude._();
  }

  static CourseIncludeList includeList({
    _is.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    CourseInclude? include,
  }) {
    return CourseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseImpl extends Course {
  _CourseImpl({
    int? id,
    required String title,
    required String subject,
    List<String>? topics,
    int? teacherId,
    String? teacherName,
    bool? isPublic,
  }) : super._(
         id: id,
         title: title,
         subject: subject,
         topics: topics,
         teacherId: teacherId,
         teacherName: teacherName,
         isPublic: isPublic,
       );

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Course copyWith({
    Object? id = _Undefined,
    String? title,
    String? subject,
    Object? topics = _Undefined,
    Object? teacherId = _Undefined,
    Object? teacherName = _Undefined,
    Object? isPublic = _Undefined,
  }) {
    return Course(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      topics: topics is List<String>?
          ? topics
          : this.topics?.map((e0) => e0).toList(),
      teacherId: teacherId is int? ? teacherId : this.teacherId,
      teacherName: teacherName is String? ? teacherName : this.teacherName,
      isPublic: isPublic is bool? ? isPublic : this.isPublic,
    );
  }
}

class CourseUpdateTable extends _is.UpdateTable<CourseTable> {
  CourseUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> topics(List<String>? value) =>
      _is.ColumnValue(
        table.topics,
        value,
      );

  _is.ColumnValue<int, int> teacherId(int? value) => _is.ColumnValue(
    table.teacherId,
    value,
  );

  _is.ColumnValue<String, String> teacherName(String? value) => _is.ColumnValue(
    table.teacherName,
    value,
  );

  _is.ColumnValue<bool, bool> isPublic(bool? value) => _is.ColumnValue(
    table.isPublic,
    value,
  );
}

class CourseTable extends _is.Table<int?> {
  CourseTable({super.tableRelation}) : super(tableName: 'course') {
    updateTable = CourseUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    topics = _is.ColumnSerializable<List<String>>(
      'topics',
      this,
    );
    teacherId = _is.ColumnInt(
      'teacherId',
      this,
    );
    teacherName = _is.ColumnString(
      'teacherName',
      this,
    );
    isPublic = _is.ColumnBool(
      'isPublic',
      this,
    );
  }

  late final CourseUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString subject;

  late final _is.ColumnSerializable<List<String>> topics;

  late final _is.ColumnInt teacherId;

  late final _is.ColumnString teacherName;

  late final _is.ColumnBool isPublic;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    subject,
    topics,
    teacherId,
    teacherName,
    isPublic,
  ];
}

class CourseInclude extends _is.IncludeObject {
  CourseInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Course.t;
}

class CourseIncludeList extends _is.IncludeList {
  CourseIncludeList._({
    _is.WhereExpressionBuilder<CourseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Course.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Course.t;
}

class CourseRepository {
  const CourseRepository._();

  /// Returns a list of [Course]s matching the given query parameters.
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
  Future<List<Course>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Course>(
      where: where?.call(Course.t),
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Course] matching the given query parameters.
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
  Future<Course?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseTable>? where,
    int? offset,
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Course>(
      where: where?.call(Course.t),
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Course] by its [id] or null if no such row exists.
  Future<Course?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Course>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Course]s in the list and returns the inserted rows.
  ///
  /// The returned [Course]s will have their `id` fields set.
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
  Future<List<Course>> insert(
    _is.DatabaseSession session,
    List<Course> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Course>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Course] and returns the inserted row.
  ///
  /// The returned [Course] will have its `id` field set.
  Future<Course> insertRow(
    _is.DatabaseSession session,
    Course row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Course>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Course]s in the list and returns the resulting rows.
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
  /// The returned [Course]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Course>> upsert(
    _is.DatabaseSession session,
    List<Course> rows, {
    required _is.ColumnSelections<CourseTable> conflictColumns,
    _is.ColumnSelections<CourseTable>? updateColumns,
    _is.WhereExpressionBuilder<CourseTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Course>(
      rows,
      conflictColumns: conflictColumns(Course.t),
      updateColumns: updateColumns?.call(Course.t),
      updateWhere: updateWhere?.call(Course.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Course] and returns the resulting row.
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
  /// The returned [Course] will have its `id` field set.
  Future<Course?> upsertRow(
    _is.DatabaseSession session,
    Course row, {
    required _is.ColumnSelections<CourseTable> conflictColumns,
    _is.ColumnSelections<CourseTable>? updateColumns,
    _is.WhereExpressionBuilder<CourseTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Course>(
      row,
      conflictColumns: conflictColumns(Course.t),
      updateColumns: updateColumns?.call(Course.t),
      updateWhere: updateWhere?.call(Course.t),
      transaction: transaction,
    );
  }

  /// Updates all [Course]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Course>> update(
    _is.DatabaseSession session,
    List<Course> rows, {
    _is.ColumnSelections<CourseTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Course>(
      rows,
      columns: columns?.call(Course.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Course]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Course> updateRow(
    _is.DatabaseSession session,
    Course row, {
    _is.ColumnSelections<CourseTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Course>(
      row,
      columns: columns?.call(Course.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Course] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Course?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CourseUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Course>(
      id,
      columnValues: columnValues(Course.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Course]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Course>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CourseUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CourseTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Course>(
      columnValues: columnValues(Course.t.updateTable),
      where: where(Course.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Course]s in the list and returns the deleted rows.
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
  Future<List<Course>> delete(
    _is.DatabaseSession session,
    List<Course> rows, {
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Course>(
      rows,
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Course].
  Future<Course> deleteRow(
    _is.DatabaseSession session,
    Course row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Course>(
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
  Future<List<Course>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CourseTable> where,
    _is.OrderByBuilder<CourseTable>? orderBy,
    _is.OrderByListBuilder<CourseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Course>(
      where: where(Course.t),
      orderBy: orderBy?.call(Course.t),
      orderByList: orderByList?.call(Course.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CourseTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Course>(
      where: where?.call(Course.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Course] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CourseTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Course>(
      where: where(Course.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
