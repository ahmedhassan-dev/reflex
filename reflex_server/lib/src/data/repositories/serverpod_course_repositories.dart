import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'interfaces.dart';

/// Serverpod ORM implementation of [ICourseRepository].
class ServerpodCourseRepository implements ICourseRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodCourseRepository(this.session, [this.transaction]);

  @override
  Future<Course?> findById(int id) async {
    return Course.db.findById(session, id, transaction: transaction);
  }

  @override
  Future<List<Course>> listAll() async {
    return Course.db.find(session, transaction: transaction);
  }

  @override
  Future<List<Course>> listByTeacher(int teacherId) async {
    return Course.db.find(
      session,
      where: (t) => t.teacherId.equals(teacherId),
      transaction: transaction,
    );
  }

  Future<List<Course>> listAccessible(int? learnerId) async {
    if (learnerId == null) {
      return Course.db.find(
        session,
        where: (t) => t.isPublic.equals(true),
        transaction: transaction,
      );
    }

    final acceptedSubs = await CourseSubscription.db.find(
      session,
      where: (t) =>
          t.studentId.equals(learnerId) &
          t.status.equals(SubscriptionStatus.accepted),
      transaction: transaction,
    );
    final acceptedCourseIds = acceptedSubs.map((s) => s.courseId).toSet();

    return Course.db.find(
      session,
      where: (t) =>
          t.isPublic.equals(true) |
          (acceptedCourseIds.isNotEmpty
              ? t.id.inSet(acceptedCourseIds)
              : Constant.bool(false)),
      transaction: transaction,
    );
  }

  @override
  Future<Course> save(Course course) async {
    if (course.id != null) {
      return Course.db.updateRow(session, course, transaction: transaction);
    }
    return Course.db.insertRow(session, course, transaction: transaction);
  }

  @override
  Future<void> unassignTeacher(int teacherId) async {
    final courses = await Course.db.find(
      session,
      where: (t) => t.teacherId.equals(teacherId),
      transaction: transaction,
    );
    for (final course in courses) {
      course.teacherId = null;
      await Course.db.updateRow(session, course, transaction: transaction);
    }
  }
}

/// Serverpod ORM implementation of [ICourseSubscriptionRepository].
class ServerpodCourseSubscriptionRepository
    implements ICourseSubscriptionRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodCourseSubscriptionRepository(this.session, [this.transaction]);

  @override
  Future<CourseSubscription?> findById(int id) async {
    return CourseSubscription.db.findById(session, id, transaction: transaction);
  }

  @override
  Future<CourseSubscription?> findByCourseAndStudent(
      int courseId, int studentId) async {
    return CourseSubscription.db.findFirstRow(
      session,
      where: (t) => t.courseId.equals(courseId) & t.studentId.equals(studentId),
      transaction: transaction,
    );
  }

  @override
  Future<List<CourseSubscription>> listByCourse(int courseId) async {
    return CourseSubscription.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
      orderBy: (t) => t.requestedAt,
      transaction: transaction,
    );
  }

  @override
  Future<List<CourseSubscription>> listByStudent(int studentId) async {
    return CourseSubscription.db.find(
      session,
      where: (t) => t.studentId.equals(studentId),
      orderBy: (t) => t.requestedAt,
      transaction: transaction,
    );
  }

  @override
  Future<CourseSubscription> save(CourseSubscription subscription) async {
    if (subscription.id != null) {
      return CourseSubscription.db
          .updateRow(session, subscription, transaction: transaction);
    }
    return CourseSubscription.db
          .insertRow(session, subscription, transaction: transaction);
  }

  @override
  Future<void> deleteByStudentId(int studentId) async {
    await CourseSubscription.db.deleteWhere(
      session,
      where: (t) => t.studentId.equals(studentId),
      transaction: transaction,
    );
  }
}
