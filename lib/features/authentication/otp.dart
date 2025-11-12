import 'package:flutter/material.dart';

import '../../export.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  int _seconds = 59;
  late Timer _timer;
  bool _isOtpFilled = false;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController?.close();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color blueColor = Color(0xFF2F5DF2);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // App Logo / Title
              CustomText(
                txt: "koovs",
                color: blueColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 30),

              // Title
              CustomText(
                txt: "Enter Verification Code",

                color: blueColor,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),

              const SizedBox(height: 10),

              // Subtitle
              CustomText(
                txt:
                    "Please enter the 6-digit code we sent\nto your registered email address.",
                align: TextAlign.center,
                color: Colors.black54,
                fontSize: 14,
                height: 1.5,
              ),

              const SizedBox(height: 16),

              // Email + Edit icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txt: "john@example.com",

                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.edit_outlined, color: blueColor, size: 18),
                ],
              ),

              const SizedBox(height: 30),

              // OTP Input Field
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  txt: "Verification code",

                  color: blueColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  inactiveColor: blueColor.withOpacity(0.3),
                  selectedColor: blueColor,
                  activeColor: blueColor,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  borderWidth: 1.5,
                ),
                animationDuration: const Duration(milliseconds: 200),
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() {
                    _isOtpFilled = value.length == 6;
                  });
                },
              ),

              gapH64,
              gapH48,

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  isChecked: _isOtpFilled,
                  text: "Submit",
                  backgroundColor: blueColor,
                  borderColor: blueColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),

              // Resend Timer
              CustomText(
                txt: _seconds > 0
                    ? "Resend - 00:${_seconds.toString().padLeft(2, '0')}"
                    : "Resend Code",
                color: Colors.black54,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
