import 'package:todo_and_note/models/course.dart';
import 'package:todo_and_note/services/courses_http_services.dart';

class CoursesRepository {
  final courseHttpServices = CoursesHttpServices();

  Future<List<Course>> getCourses() async {
    return CoursesHttpServices().getCourses();
  }
}
