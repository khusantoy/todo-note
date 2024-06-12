import 'package:todo_and_note/services/user_http_services.dart';

class UsersRepository {
  final userHttpServices = UserHttpServices();

  Future<void> addUser() async {
    await userHttpServices.addUser();
  }

  Future<void> addCourseToFavorite(String courseId) async {
    await userHttpServices.addCourseToFavorite(courseId);
  }
}
