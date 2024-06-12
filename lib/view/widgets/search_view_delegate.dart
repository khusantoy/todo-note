import 'package:flutter/material.dart';
import 'package:todo_and_note/models/course.dart';
import 'package:todo_and_note/view/screens/course_details_screen.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final Future<List<Course>> data;

  SearchViewDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions available'));
        } else {
          final suggestionList = query.isEmpty
              ? snapshot.data!
              : snapshot.data!
                  .where((element) => element.title.contains(query))
                  .toList();
          return suggestionList.isEmpty
              ? const NoResultWidget()
              : ListView.builder(
                  itemCount: suggestionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        suggestionList[index].title,
                      ),
                      onTap: () {
                        close(context, suggestionList[index].title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CourseDetailsScreen(
                              course: suggestionList[index],
                            ),
                          ),
                        );
                      },
                    );
                  });
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Result Found'),
    );
  }
}
