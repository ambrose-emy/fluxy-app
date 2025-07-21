import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/forgotpassword.dart';
import 'pages/otp.dart';
import 'pages/resetpassword.dart';
import 'pages/locationscreen.dart';

void main() {
  runApp(LuxyCar());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => ForgotPasswordScreen()),
    GoRoute(
      path: '/otp/:phone',
      builder: (context, state) {
        final phone = state.pathParameters['phone'] ?? '';
        return OtpVerificationScreen(phone: phone);
      },
    ),

    GoRoute(
      path: '/reset/:token',
      builder: (context, state) {
        final token = state.pathParameters['token'] ?? '';
        return ResetPasswordScreen(token: token);
      },
    ),
    GoRoute(
      path: '/location',
      builder: (context, state) {
        final token = state.extra as String?;
        return LocationScreen(token: token);
        //builder: (context, state) => LocationScreen()
      },
    ),
  ],
);

class LuxyCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Password Reset App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
