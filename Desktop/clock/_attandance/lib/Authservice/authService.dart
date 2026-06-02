import 'dart:convert';
import 'package:_attandance/ApiConstants/apiConstants.dart';
import 'package:_attandance/SesssionManager/sessionManager.dart';
import 'package:http/http.dart' as http;

class AuthService {

  //login
 Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {
  try {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "identifier": email,
        "password": password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = body['accessToken'];
      final user = body['user'];

      await SessionManager.saveSession(
        token: token,
        name: user['name'],
        employeeId: user['employeeId'],
      );

      return {
        "success": true,
        "message": "Login successful",
      };
    } else {
      return {
        "success": false,
        "message": body['message'] ?? response.body,
      };
    }
  } catch (e) {
    return {
      "success": false,
      "message": e.toString(),
    };
  }
}
}