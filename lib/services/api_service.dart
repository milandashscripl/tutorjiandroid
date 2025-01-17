import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://tutorji.onrender.com/api";

  /// Register a new user
  static Future<Map<String, dynamic>> registerUser(
      String name,
      String email,
      String password,
      String contact,
      String aadhar,
      String address,
      String profilePicturePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/users/register"),
    );

    // Add fields
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['contact'] = contact;
    request.fields['aadhar'] = aadhar;
    request.fields['address'] = address;

    // Add file if profile picture is selected
    if (profilePicturePath.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('profilePicture', profilePicturePath),
      );
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 201) {
      // Parse and return the response
      return jsonDecode(await response.stream.bytesToString());
    } else {
      throw Exception("Failed to register user: ${response.statusCode}");
    }
  }

  /// Login user by email
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login'); // Replace with your login API endpoint

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  /// Fetch user profile
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final url = Uri.parse("$baseUrl/users/profile/$userId");
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch user profile: ${response.statusCode}");
    }
  }
}
