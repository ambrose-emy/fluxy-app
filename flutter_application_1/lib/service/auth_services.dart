import 'dart:async';
import 'real_auth_services.dart';

abstract class AuthService {
  Future<Map<String, dynamic>> forgotPassword(String phone);
}

const bool useMock = true; // Set false for real API

AuthService getAuthService() {
  return RealAuthService();
}
