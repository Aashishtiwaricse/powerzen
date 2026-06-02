import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _tokenKey = "access_token";
  static const String _nameKey = "user_name";
  static const String _employeeIdKey = "employee_id";
static const String _statusKey = "status";
static const String _hoursKey = "hours";
static const String _amountKey = "amount";

  /// 🔐 Save Data
  static Future<void> saveSession({
    required String token,
    required String name,
    required int employeeId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
    await prefs.setString(_nameKey, name);
    await prefs.setInt(_employeeIdKey, employeeId);
  }

  /// 📥 Get Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// 📥 Get Name
  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  /// 📥 Get Employee ID
  static Future<int?> getEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_employeeIdKey);
  }

  /// 🚪 Logout
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  static Future<void> saveStatus(String status) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_statusKey, status);
}

static Future<String?> getStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_statusKey);
}

static Future<void> saveWorkData({
  required String status,
  required double hours,
  required double amount,
}) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(_statusKey, status);
  await prefs.setDouble(_hoursKey, hours);
  await prefs.setDouble(_amountKey, amount);
}

static Future<void> clearStatus() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_statusKey);
}
}