import 'package:flutter/material.dart';

import '../../export.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailFocus = FocusNode();
  // final FocusNode _focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final passwordFocus = FocusNode();

  bool _showNewPassEye = false;
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    PasswordController.addListener(_passwordListener);
    emailController.addListener(_checkFormFilled); // jab email change ho
    PasswordController.addListener(_checkFormFilled); // jab password change ho
  }

  void _passwordListener() {
    final shouldShow = PasswordController.text.isNotEmpty;
    if (shouldShow != _showNewPassEye) {
      setState(() => _showNewPassEye = shouldShow);
    }
  }

  ///  check karega ki dono fields filled hain ya nahi
  void _checkFormFilled() {
    final isFilled =
        emailController.text.isNotEmpty && PasswordController.text.isNotEmpty;

    if (isFilled != _isFormFilled) {
      setState(() => _isFormFilled = isFilled);
    }
  }

  // bool isChecked = false;
  bool _isOtpFilled = false;

  final Color blueColor = const Color(0xFF345CFF);

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor = Colors.grey.shade400;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "koovs",
                style: TextStyle(
                  color: blueColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapH32,
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your Register email\naddress to reset your password",
                style: TextStyle(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              gapH20,

              CustomAnimatedTextField(
                controller: emailController,
                focusNode: emailFocus,
                labelText: "Email ID",
                hintText: "Email ID",
                prefixIcon: Icons.email_outlined,
                iconColor: blueColor,
                borderColor: blueColor,
                textColor: Colors.black87,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  }
                  if (!value.contains('@')) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              SizedBox(height: 300),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  isChecked: _isOtpFilled,
                  text: "Submit",
                  backgroundColor: _isFormFilled ? blueColor : inactiveColor,
                  borderColor: blueColor,
                  textColor: Colors.white,
                  onPressed: _isFormFilled
                      ? () {
                          debugPrint("Submit");
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
