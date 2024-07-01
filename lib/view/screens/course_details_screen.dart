import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/users_controller.dart';
import 'package:todo_and_note/models/course.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;
  CourseDetailsScreen({super.key, required this.course});

  final userController = UsersController();

  void addCourseToFavorite() {
    userController.addCourseToFavorite(course.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.course_details),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart),
          ),
          IconButton(
            onPressed: addCourseToFavorite,
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                course.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              course.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: "Price: "),
                  TextSpan(
                    text: course.price.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: " sum",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/successfulpaymentscreen',
                      arguments: course.lessons);
                },
                child: const Text(
                  "Free Enroll Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
