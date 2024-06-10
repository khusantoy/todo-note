import 'package:flutter/material.dart';
import 'package:todo_and_note/main.dart';
import 'package:todo_and_note/services/auth_http_services.dart';
import 'package:todo_and_note/view/screens/main_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFFDD761C),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit info',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Edit Info'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'set photo',
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Set Profile Photo'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const MyApp();
                      },
                    ),
                  );
                  return AuthHttpServices.logout();
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Log Out'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                    "https://www.elitesingles.co.uk/wp-content/uploads/sites/59/2019/11/2b_en_articleslide_sm2-350x264.jpg",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "+998 972320718",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
