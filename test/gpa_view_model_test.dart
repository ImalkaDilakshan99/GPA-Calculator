import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/models/course_model.dart';
import 'package:gpa_calculator/models/semester_model.dart';
import 'package:gpa_calculator/viewModels/gpa_view_model.dart';

void main() {
  group('GPANotifier.gradeToPoint', () {
    test('converts standard letter grades correctly', () {
      expect(GPANotifier.gradeToPoint('A+'), 4.0);
      expect(GPANotifier.gradeToPoint('A'), 4.0);
      expect(GPANotifier.gradeToPoint('A-'), 3.7);
      expect(GPANotifier.gradeToPoint('B+'), 3.3);
      expect(GPANotifier.gradeToPoint('B'), 3.0);
      expect(GPANotifier.gradeToPoint('B-'), 2.7);
      expect(GPANotifier.gradeToPoint('C+'), 2.3);
      expect(GPANotifier.gradeToPoint('C'), 2.0);
      expect(GPANotifier.gradeToPoint('C-'), 1.7);
      expect(GPANotifier.gradeToPoint('D'), 1.0);
      expect(GPANotifier.gradeToPoint('F'), 0.0);
    });

    test('returns 0.0 for unknown grades', () {
      expect(GPANotifier.gradeToPoint('X'), 0.0);
      expect(GPANotifier.gradeToPoint(''), 0.0);
      expect(GPANotifier.gradeToPoint('Z+'), 0.0);
    });

    test('handles whitespace-padded grades', () {
      expect(GPANotifier.gradeToPoint(' A '), 4.0);
      expect(GPANotifier.gradeToPoint('  B+  '), 3.3);
    });
  });

  group('GPANotifier.calculateGPA', () {
    late ProviderContainer container;
    late GPANotifier notifier;

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(gpaProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('returns 0.0 when no courses exist', () {
      expect(notifier.calculateGPA(), 0.0);
    });

    test('calculates GPA for a single course', () {
      notifier.addCourse();
      final courses = container.read(gpaProvider);
      notifier.updateCourse(courses.first.id, credits: 3.0, grade: 'A');

      // GPA = (3 × 4.0) / 3 = 4.0
      expect(notifier.calculateGPA(), 4.0);
    });

    test('calculates GPA for multiple courses correctly', () {
      // Add three courses
      notifier.addCourse();
      notifier.addCourse();
      notifier.addCourse();

      final courses = container.read(gpaProvider);

      notifier.updateCourse(courses[0].id, credits: 3.0, grade: 'A');  // 3 × 4.0 = 12.0
      notifier.updateCourse(courses[1].id, credits: 4.0, grade: 'B+'); // 4 × 3.3 = 13.2
      notifier.updateCourse(courses[2].id, credits: 3.0, grade: 'C');  // 3 × 2.0 = 6.0

      // GPA = (12.0 + 13.2 + 6.0) / (3 + 4 + 3) = 31.2 / 10 = 3.12
      expect(notifier.calculateGPA(), closeTo(3.12, 0.001));
    });

    test('calculates GPA with an F grade (0.0 points)', () {
      notifier.addCourse();
      notifier.addCourse();

      final courses = container.read(gpaProvider);

      notifier.updateCourse(courses[0].id, credits: 3.0, grade: 'A');  // 3 × 4.0 = 12.0
      notifier.updateCourse(courses[1].id, credits: 3.0, grade: 'F');  // 3 × 0.0 = 0.0

      // GPA = (12.0 + 0.0) / (3 + 3) = 12.0 / 6 = 2.0
      expect(notifier.calculateGPA(), 2.0);
    });

    test('handles all A grades → perfect 4.0', () {
      for (int i = 0; i < 5; i++) {
        notifier.addCourse();
      }
      final courses = container.read(gpaProvider);
      for (final course in courses) {
        notifier.updateCourse(course.id, credits: 3.0, grade: 'A');
      }

      expect(notifier.calculateGPA(), 4.0);
    });

    test('handles all F grades → 0.0', () {
      for (int i = 0; i < 3; i++) {
        notifier.addCourse();
      }
      final courses = container.read(gpaProvider);
      for (final course in courses) {
        notifier.updateCourse(course.id, credits: 3.0, grade: 'F');
      }

      expect(notifier.calculateGPA(), 0.0);
    });

    test('correctly weights different credit hours', () {
      notifier.addCourse();
      notifier.addCourse();

      final courses = container.read(gpaProvider);

      // Heavy course (4 credits) with B, light course (1 credit) with A
      notifier.updateCourse(courses[0].id, credits: 4.0, grade: 'B');  // 4 × 3.0 = 12.0
      notifier.updateCourse(courses[1].id, credits: 1.0, grade: 'A');  // 1 × 4.0 = 4.0

      // GPA = (12.0 + 4.0) / (4 + 1) = 16.0 / 5 = 3.2
      expect(notifier.calculateGPA(), closeTo(3.2, 0.001));
    });
  });

  group('GPANotifier course management', () {
    late ProviderContainer container;
    late GPANotifier notifier;

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(gpaProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('addCourse increases list length', () {
      expect(container.read(gpaProvider), isEmpty);
      notifier.addCourse();
      expect(container.read(gpaProvider).length, 1);
      notifier.addCourse();
      expect(container.read(gpaProvider).length, 2);
    });

    test('removeCourse decreases list length', () {
      notifier.addCourse();
      notifier.addCourse();
      final id = container.read(gpaProvider).first.id;

      notifier.removeCourse(id);
      expect(container.read(gpaProvider).length, 1);
    });

    test('updateCourse modifies the correct course', () {
      notifier.addCourse();
      notifier.addCourse();

      final courses = container.read(gpaProvider);
      notifier.updateCourse(courses[0].id, name: 'Math', credits: 4.0, grade: 'B+');

      final updated = container.read(gpaProvider);
      expect(updated[0].name, 'Math');
      expect(updated[0].credits, 4.0);
      expect(updated[0].grade, 'B+');
      // Second course should be unchanged
      expect(updated[1].name, '');
    });

    test('totalCredits sums all course credits', () {
      notifier.addCourse();
      notifier.addCourse();

      final courses = container.read(gpaProvider);
      notifier.updateCourse(courses[0].id, credits: 3.0);
      notifier.updateCourse(courses[1].id, credits: 4.0);

      expect(notifier.totalCredits(), 7.0);
    });
  });

  group('Course model', () {
    test('default values are correct', () {
      const course = Course(id: '1');
      expect(course.name, '');
      expect(course.credits, 3.0);
      expect(course.grade, 'A');
    });

    test('copyWith creates a new instance with updated fields', () {
      const original = Course(id: '1', name: 'Math', credits: 3.0, grade: 'A');
      final copy = original.copyWith(grade: 'B', credits: 4.0);

      expect(copy.id, '1');
      expect(copy.name, 'Math');
      expect(copy.credits, 4.0);
      expect(copy.grade, 'B');
    });

    test('copyWith preserves unmodified fields', () {
      const original = Course(id: '1', name: 'Science', credits: 2.0, grade: 'C');
      final copy = original.copyWith(name: 'Physics');

      expect(copy.id, '1');
      expect(copy.name, 'Physics');
      expect(copy.credits, 2.0);
      expect(copy.grade, 'C');
    });
  });

  group('SemesterNotifier', () {
    late ProviderContainer container;
    late SemesterNotifier notifier;

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(semesterProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('starts with empty list', () {
      expect(container.read(semesterProvider), isEmpty);
    });

    test('addSemester adds to the list', () {
      notifier.addSemester(const SemesterModel(id: '1', name: 'Fall', year: '2024'));
      expect(container.read(semesterProvider).length, 1);
    });

    test('removeSemester removes by id', () {
      notifier.addSemester(const SemesterModel(id: '1', name: 'Fall', year: '2024'));
      notifier.addSemester(const SemesterModel(id: '2', name: 'Spring', year: '2025'));

      notifier.removeSemester('1');
      final semesters = container.read(semesterProvider);
      expect(semesters.length, 1);
      expect(semesters.first.name, 'Spring');
    });

    test('calculateCumulativeGPA returns 0.0 for empty list', () {
      expect(notifier.calculateCumulativeGPA(), 0.0);
    });

    test('calculateCumulativeGPA averages semester GPAs', () {
      notifier.addSemester(const SemesterModel(id: '1', name: 'S1', year: '2024', gpa: 3.5));
      notifier.addSemester(const SemesterModel(id: '2', name: 'S2', year: '2024', gpa: 3.0));

      // (3.5 + 3.0) / 2 = 3.25
      expect(notifier.calculateCumulativeGPA(), closeTo(3.25, 0.001));
    });
  });

  group('gradeDefinitions', () {
    test('contains all expected grades', () {
      final gradeStrings = gradeDefinitions.map((g) => g.grade).toList();
      expect(gradeStrings, contains('A+'));
      expect(gradeStrings, contains('A'));
      expect(gradeStrings, contains('A-'));
      expect(gradeStrings, contains('B+'));
      expect(gradeStrings, contains('B'));
      expect(gradeStrings, contains('B-'));
      expect(gradeStrings, contains('C+'));
      expect(gradeStrings, contains('C'));
      expect(gradeStrings, contains('C-'));
      expect(gradeStrings, contains('D'));
      expect(gradeStrings, contains('F'));
    });

    test('grade points are in descending order', () {
      for (int i = 1; i < gradeDefinitions.length; i++) {
        expect(
          gradeDefinitions[i].gradePoint,
          lessThanOrEqualTo(gradeDefinitions[i - 1].gradePoint),
          reason: '${gradeDefinitions[i].grade} should have gradePoint <= ${gradeDefinitions[i - 1].grade}',
        );
      }
    });

    test('A+ and A both map to 4.0', () {
      final aPlus = gradeDefinitions.firstWhere((g) => g.grade == 'A+');
      final a = gradeDefinitions.firstWhere((g) => g.grade == 'A');
      expect(aPlus.gradePoint, 4.0);
      expect(a.gradePoint, 4.0);
    });

    test('F maps to 0.0', () {
      final f = gradeDefinitions.firstWhere((g) => g.grade == 'F');
      expect(f.gradePoint, 0.0);
    });
  });
}
