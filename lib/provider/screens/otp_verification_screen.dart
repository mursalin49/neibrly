import 'dart:async';
import 'package:flutter/material.dart';
import 'EnterNewPasswordScreen.dart';

class AuthenticationCodeScreen extends StatefulWidget {
  const AuthenticationCodeScreen({super.key});

  @override
  State<AuthenticationCodeScreen> createState() =>
      _AuthenticationCodeScreenState();
}

class _AuthenticationCodeScreenState extends State<AuthenticationCodeScreen> {
  List<String> otp = List.filled(5, '');
  int secondsRemaining = 34;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    secondsRemaining = 34;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onNumberPressed(String value) {
    for (int i = 0; i < otp.length; i++) {
      if (otp[i].isEmpty) {
        setState(() => otp[i] = value);
        break;
      }
    }
  }

  void _onBackspace() {
    for (int i = otp.length - 1; i >= 0; i--) {
      if (otp[i].isNotEmpty) {
        setState(() => otp[i] = '');
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Authentication Code",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: "Enter 5-digit code we just texted to your Email ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "jhon@gmail.com",
                        style: TextStyle(
                          color: Color(0xFF1E7B60),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                      (index) => Container(
                    width: 55,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: otp[index].isNotEmpty
                            ? const Color(0xFF1E7B60)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      otp[index],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Resend + Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn’t receive the OTP ",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "00:${secondsRemaining.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      if (secondsRemaining == 0) startTimer();
                    },
                    child: Text(
                      "Resend?",
                      style: TextStyle(
                        color: secondsRemaining == 0
                            ? const Color(0xFF1E7B60)
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E7B60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterNewPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ✅ Custom Dial Pad
              Expanded(
                child: Container(
                  color: const Color(0xFFF3F4F6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildDialRow([
                        {"number": "1", "letters": ""},
                        {"number": "2", "letters": "ABC"},
                        {"number": "3", "letters": "DEF"},
                      ]),
                      const SizedBox(height: 12),
                      buildDialRow([
                        {"number": "4", "letters": "GHI"},
                        {"number": "5", "letters": "JKL"},
                        {"number": "6", "letters": "MNO"},
                      ]),
                      const SizedBox(height: 12),
                      buildDialRow([
                        {"number": "7", "letters": "PQRS"},
                        {"number": "8", "letters": "TUV"},
                        {"number": "9", "letters": "WXYZ"},
                      ]),
                      const SizedBox(height: 12),
                      buildDialRow([
                        {"number": "", "letters": ""},
                        {"number": "0", "letters": ""},
                        {"number": "⌫", "letters": ""},
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Helper for dial pad rows
  Widget buildDialRow(List<Map<String, String>> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        final number = key["number"]!;
        final letters = key["letters"]!;
        if (number.isEmpty) {
          return const SizedBox(width: 90);
        } else if (number == "⌫") {
          return GestureDetector(
            onTap: _onBackspace,
            child: Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.backspace_outlined,
                color: Colors.black87,
                size: 26,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => _onNumberPressed(number),
            child: Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (letters.isNotEmpty)
                    Text(
                      letters,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        letterSpacing: 1,
                        height: 1.1,
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}
