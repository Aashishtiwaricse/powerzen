import 'dart:convert';
import 'package:_attandance/ApiConstants/apiConstants.dart';
import 'package:_attandance/SesssionManager/sessionManager.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart'; // ✅ ADD THIS


class AttendanceService {
   PlatformFile? selectedFile;
int? uploadedDocumentId;

  /// ✅ GET ASSIGNED PROJECTS
  Future<List<dynamic>> getProjects() async {
    final token = await SessionManager.getToken();

    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.assignedProjects),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  /// ✅ CLOCK IN
Future<Map<String, dynamic>?> clockIn(int projectId) async {
  try {
    final token = await SessionManager.getToken();

    print("🔑 Token: $token");

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.clockIn),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "projectId": projectId,
      }),
    );

    print("📡 STATUS: ${response.statusCode}");
    print("📡 BODY: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      await SessionManager.saveStatus(data['session']['status']);

      return data;
    } 
    
    if (response.statusCode == 400) {
  final data = jsonDecode(response.body);

  if (data['error'] == "Already clocked in") {
    await SessionManager.saveStatus("OPEN");

    return {
      "session": {"status": "OPEN"}
    };
  }
}
    
    else {
      print("❌ ClockIn API Failed");
      return null;
    }
  } catch (e) {
    print("🔥 Exception: $e");
    return null;
  }
  return null;
}

  /// ✅ CLOCK OUT
 Future<Map<String, dynamic>?> clockOut() async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.clockOut),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("📡 CLOCK OUT STATUS: ${response.statusCode}");
    print("📡 CLOCK OUT BODY: ${response.body}");

    final data = jsonDecode(response.body);

    /// ✅ SUCCESS
    if (response.statusCode == 200) {
      await SessionManager.saveWorkData(
        status: data['session']['status'],
        hours: (data['hoursWorked'] ?? 0).toDouble(),
        amount: (data['amount'] ?? 0).toDouble(),
      );

      return data;
    }

    /// ❌ 400 → CLEAR ONLY STATUS
    if (response.statusCode == 400) {
      await SessionManager.clearStatus();

      return {
        "error": data['error'] ?? "Session reset. Please try again."
      };
    }

    /// ❌ 401 → TOKEN EXPIRED (optional logout)
    if (response.statusCode == 401) {
      return {
        "error": "Session expired. Please login again."
      };
    }

    return {
      "error": "Something went wrong"
    };

  } catch (e) {
    print("🔥 ClockOut Exception: $e");

    return {
      "error": "Network error"
    };
  }
}

  //get claims

  Future<List<dynamic>> getClaims() async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getClaims),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['claims'] ?? [];
    } else {
      print("Failed to fetch claims: ${response.body}");
      return [];
    }
  } catch (e) {
    print("Claims Error: $e");
    return [];
  }
}



Future<bool> createClaim({
  required double amount,
  required String description,
  required int projectId,
  required String category,
  required String documentId,
}) async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getClaims),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "amount": amount,
        "description": description,
        "projectId": projectId,
        "category": category,
        "documentId": documentId,
      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return true;
    } else {
      print("Create Claim Failed: ${response.body}");
      return false;
    }
  } catch (e) {
    print("Create Claim Error: $e");
    return false;
  }
}


//get leaves 
Future<List<dynamic>> getLeaves() async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getLeaves),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['leaves'] ?? [];
    }

    return [];
  } catch (e) {
    print(e);
    return [];
  }
}


//leaves types. 
Future<List<dynamic>> getLeaveTypes() async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.get(

      Uri.parse(ApiConstants.baseUrl + ApiConstants.getLeaveTypes),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['leaveTypes'] ?? [];
    }

    return [];
  } catch (e) {
    print(e);
    return [];
  }
}
// create leaves 

Future<bool> createLeave({
  required String leaveTypeId,
  required String startDate,
  required String endDate,
  required String reason,
  int? documentId,
}) async {
  try {
    final token = await SessionManager.getToken();

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.createLeave),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "leaveTypeId": leaveTypeId,
        "startDate": startDate,
        "endDate": endDate,
        "reason": reason,
        "documentId": documentId,
      }),
    );

    return response.statusCode == 200 ||
        response.statusCode == 201;
  } catch (e) {
    print(e);
    return false;
  }
}


//document upload

Future<int?> uploadDocument(PlatformFile file) async {
  try {
    final token = await SessionManager.getToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl + "/api/documents/upload"),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path!,
      ),
    );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    print("UPLOAD RESPONSE: $responseData");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(responseData);

      return data['id']; // ✅ FIXED
    }

    return null;
  } catch (e) {
    print("Upload Error: $e");
    return null;
  }
}}