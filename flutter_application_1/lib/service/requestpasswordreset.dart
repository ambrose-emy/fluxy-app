import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth_services.dart';

Future<void> requestPasswordReset({
  required BuildContext context,
  required String phone,
  required Function(bool) setLoading,
}) async {
  final AuthService authService = getAuthService();

  setLoading(true);

  final result = await authService.forgotPassword(phone);

  if (!context.mounted) return;

  setLoading(false);

  if (result['success']) {
    context.push('/otp/$phone');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'] ?? 'Failed to send OTP')),
    );
  }
}
