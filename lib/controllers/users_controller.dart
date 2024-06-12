import 'package:todo_and_note/repositories/users_repository.dart';

class UsersController {
  final userRepository = UsersRepository();

  Future<void> addUser() async {
    await userRepository.addUser();
  }

  Future<void> addCourseToFavorite(String courseId) async {
    await userRepository.addCourseToFavorite(courseId);
  }
}
