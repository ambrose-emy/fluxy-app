import 'dart:async';
import 'auth_services.dart';

class MockAuthService implements AuthService {
  @override
  Future<Map<String, dynamic>> forgotPassword(String phone) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (phone.startsWith("0")) {
      return {'success': true, 'message': 'Mock OTP sent to $phone'};
    } else {
      return {'success': false, 'message': 'Invalid phone number'};
    }
  }
}
