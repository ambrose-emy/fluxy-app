import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone;

  // Add the Key? key parameter and mark constructor const
  const OtpVerificationScreen({super.key, required this.phone});
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpCode = "";
  bool isLoading = false;

  Future<void> verifyOtp(String otp) async {
    setState(() => isLoading = true);

    // Proceed with real API call
    final response = await http.post(
      Uri.parse('https://yourapi.com/api/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': widget.phone, 'otp': otp}),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Pass actual token
      context.go('/location', extra: token);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid OTP')));
    }
  }

  void resendOtp() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('OTP resent to ${widget.phone}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/otp_image.png', height: 180),
            const SizedBox(height: 24),
            const Text(
              'Almost There!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Enter the OTP code we sent to your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              autoFocus: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: Colors.purple,
                selectedColor: Colors.purple,
                inactiveColor: Colors.grey,
              ),
              onChanged: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't get code? "),
                GestureDetector(
                  onTap: resendOtp,
                  child: const Text(
                    'Resend otp',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    isLoading || otpCode.length != 4
                        ? null
                        : () => verifyOtp(otpCode),
                child: Text(
                  isLoading ? "Verifying..." : "Verify",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















// Bypass actual API if test OTP is entered
    // if (otp == "1234") {
    //   await Future.delayed(Duration(seconds: 1));
    //   setState(() => isLoading = false);

    //   const dummyToken = "test-token-123";
    //   context.go('/location', extra: dummyToken);
    //   return;
    // }



// Future<void> verifyOtp(String otp) async {
  //   setState(() => isLoading = true);

  //   final response = await http.post(
  //     Uri.parse('https://yourapi.com/api/auth/verify-otp'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'phone': widget.phone, 'otp': otp}),
  //   );

  //   setState(() => isLoading = false);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final token = data['token'];
  //     //context.go('/location');

  //     // Navigate to the location screen with the dummytoken
  //     context.go('/location', extra: dummyToken);
  //   } else {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Invalid OTP')));
  //   }
  // }
