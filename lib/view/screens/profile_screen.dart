import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:todo_and_note/main.dart';
import 'package:todo_and_note/services/auth_http_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) changeLanguageCallback;
  const ProfileScreen({super.key, required this.changeLanguageCallback});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDark = false;
  String _selectedLanguage = 'English'; // Default selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(
            color: Color(0xFFDD761C),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: AppLocalizations.of(context)!.edit_info,
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 15,
                    ),
                    Text(AppLocalizations.of(context)!.edit_info),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'set photo',
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(AppLocalizations.of(context)!.set_profile_photo),
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
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(AppLocalizations.of(context)!.log_out),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
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
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.theme),
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = !isDark;

                  isDark
                      ? AdaptiveTheme.of(context).setDark()
                      : AdaptiveTheme.of(context).setLight();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.change_lang,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                      int langIndex = 0;
                      switch (newValue) {
                        case 'English':
                          langIndex = 0;
                          break;
                        case 'Russian':
                          langIndex = 1;
                          break;
                        case 'Uzbek':
                          langIndex = 2;
                          break;
                      }
                      widget.changeLanguageCallback(langIndex);
                    });
                  },
                  items: <String>['English', 'Russian', 'Uzbek']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
