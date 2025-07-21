import 'dart:async';
import 'real_auth_services.dart';
import 'package:flutter_application_1/service/mock_auth_sevices.dart';

abstract class AuthService {
  Future<Map<String, dynamic>> forgotPassword(String phone);
}

const bool useMock = true; // Set false for real API

AuthService getAuthService() {
  return useMock ? MockAuthService() : RealAuthService();
}
