import 'package:todo_and_note/models/course.dart';
import 'package:todo_and_note/repositories/courses_repository.dart';

class CourseController {
  final coursesRepository = CoursesRepository();

  List<Course> _list = [];

  Future<List<Course>> get list async {
    _list = await coursesRepository.getCourses();
    return [..._list];
  }
}
