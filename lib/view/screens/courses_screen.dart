import 'package:flutter/material.dart';
import 'package:todo_and_note/controllers/course_controller.dart';
import 'package:todo_and_note/view/screens/course_details_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final coursesController = CourseController();

  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isListView = !isListView;
                });
              },
              icon: isListView
                  ? const Icon(Icons.list)
                  : const Icon(Icons.grid_view_sharp),
            )
          ],
        ),
      ),
      Expanded(
        child: FutureBuilder(
          future: coursesController.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No available courses."),
              );
            }
            final courses = snapshot.data;
            return courses == null
                ? const Center(
                    child: Text("No available courses. You can add it."),
                  )
                : isListView
                    ? ListView.builder(
                        padding: const EdgeInsets.all(15.0),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => CourseDetailsScreen(
                                      course: course,
                                    ),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(10),
                              tileColor: const Color(0xFFFEB941),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Container(
                                width: 100,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  course.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                course.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                course.description,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: courses.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          final course = courses[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      CourseDetailsScreen(course: course),
                                ),
                              );
                            },
                            child: Card(
                              color: const Color(0xFFFEB941),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Image.network(
                                      course.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          course.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          course.description,
                                          overflow:
                                              course.description.length > 40
                                                  ? TextOverflow.ellipsis
                                                  : null,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    ]);
  }
}
