import 'dart:convert';

import 'package:_attandance/ApiConstants/apiConstants.dart';
import 'package:_attandance/SesssionManager/sessionManager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<int?> uploadDocument(PlatformFile file) async {
  try {
    final token = await SessionManager.getToken();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.baseUrl+ ApiConstants.documentupload),
    );

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path!,
      ),
    );

    final response = await request.send();

    final responseData =
        await response.stream.bytesToString();

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final data = jsonDecode(responseData);

      return data['document']['id'];
    }

    print(responseData);
    return null;
  } catch (e) {
    print("Upload Error: $e");
    return null;
  }
}