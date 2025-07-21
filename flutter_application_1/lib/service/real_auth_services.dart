import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_services.dart';

class RealAuthService implements AuthService {
  final String baseUrl = 'http://serverIP/api';

  @override
  Future<Map<String, dynamic>> forgotPassword(String phone) async {
    final url = Uri.parse('$baseUrl/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'OTP sent'};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Something went wrong',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection failed: $e'};
    }
  }
}
