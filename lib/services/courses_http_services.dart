import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_and_note/models/course.dart';
import 'package:http/http.dart' as http;

class CoursesHttpServices {
  Future<List<Course>> getCourses() async {
    Uri url = Uri.parse(
      "https://lesson47-bcb67-default-rtdb.firebaseio.com/courses.json",
    );
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      List<Course> loadedCourses = [];
      if (data != null && data is Map<String, dynamic>) {
        (data).forEach((key, value) {
          value['id'] = key;
          loadedCourses.add(Course.fromJson(value));
        });
      }
      return loadedCourses;
    } catch (e) {
      debugPrint(e.toString());
    }

    return [];
  }
}
