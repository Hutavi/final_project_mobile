import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_hub/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/services/dio_client.dart';

Future<void> clearLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print('Local storage cleared successfully');
}

class ApiManager {
  static Future<User?> getUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://34.16.137.128/api/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print('User info: ${userData.toString()}');

        // Tạo đối tượng User từ dữ liệu
        User? user = User.fromMapUser(userData['result']);
        // Kiểm tra dữ liệu người dùng hợp lệ
        if (user.id != null) {
          return user;
        } else {
          // Xử lý dữ liệu người dùng không hợp lệ
          print('Invalid user data');
          return null;
        }
      } else {
        // Xử lý lỗi từ API
        print('Failed to load user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Xử lý lỗi khi gọi API
      print('Error fetching user info: $e');
      return null;
    }
  }
}

class TokenManager {
  static Future<String> getTokenFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  }

  static Future<void> saveTokenToLocal(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  static Future<void> removeTokenFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
  }
}
