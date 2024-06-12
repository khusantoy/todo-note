import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserHttpServices {
  Future<void> addUser() async {
    Uri url = Uri.parse(
        "https://lesson47-bcb67-default-rtdb.firebaseio.com/users.json");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? userId = sharedPreferences.getString("userId");

    await http.post(
      url,
      body: jsonEncode(
        {
          "userId": userId,
        },
      ),
    );
  }

  Future<String> getUserById(String userId) async {
    // Ma'lum bir userId ga ega foydalanuvchini olish uchun URL ni sozlash
    Uri url = Uri.parse(
        "https://lesson47-bcb67-default-rtdb.firebaseio.com/users.json?orderBy=\"userId\"&equalTo=\"$userId\"");

    // Firebase'dan userId "aie37d" ga teng foydalanuvchini olish uchun so'rov
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Javob muvaffaqiyatli bo'lsa, foydalanuvchini ekranga chiqarish
      print("Foydalanuvchi ma'lumotlari: ${response.body}");
    } else {
      // Xatolik yuz bergan bo'lsa, xatolikni chiqarish
      print("Ma'lumot olishda xatolik yuz berdi: ${response.statusCode}");
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    String key = data.keys.first;
    return key;
  }

  Future<void> addCourseToFavorite(String courseId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");

    String userKey = await getUserById(userId!);

    Uri userUrl = Uri.parse(
        "https://lesson47-bcb67-default-rtdb.firebaseio.com/users/$userKey.json");

    // Mavjud foydalanuvchini olish
    final getUserResponse = await http.get(userUrl);
    if (getUserResponse.statusCode != 200) {
      print("Failed to get user: ${getUserResponse.statusCode}");
      print("Response: ${getUserResponse.body}");
      return;
    }

    Map<String, dynamic> userData = jsonDecode(getUserResponse.body) ?? {};

    // Cart mavjudligini tekshirish va yaratish
    List<dynamic> currentCart = userData['cart'] ?? [];

    // Yangi courseId ni cart ro'yxatiga qo'shish
    currentCart.add(courseId);

    // Yangilangan user ma'lumotlarini yozish
    userData['cart'] = currentCart;

    final patchUserResponse = await http.patch(
      userUrl,
      body: jsonEncode({"cart": currentCart}),
    );

    if (patchUserResponse.statusCode == 200) {
      print("User cart updated successfully: ${patchUserResponse.body}");
    } else {
      print("Failed to update user cart: ${patchUserResponse.statusCode}");
      print("Response: ${patchUserResponse.body}");
    }
  }
}
