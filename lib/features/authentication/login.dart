import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logisticdriverapp/common_widgets/cuntom_textfield.dart';
import 'package:logisticdriverapp/common_widgets/custom_button.dart';
import 'package:logisticdriverapp/common_widgets/custom_text.dart';
import 'package:logisticdriverapp/constants/gap.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailFocus = FocusNode();
  // final FocusNode _focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool _obscureNewPass = true;

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
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your email id or password to Sign In.",
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
              gapH24,

              /// New Password Field
              CustomAnimatedTextField(
                controller: PasswordController,
                focusNode: passwordFocus,
                labelText: "Password",
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                iconColor: blueColor,
                borderColor: blueColor,
                textColor: Colors.black87,
                obscureText: _obscureNewPass,
                suffixIcon: _showNewPassEye
                    ? IconButton(
                        icon: Icon(
                          _obscureNewPass
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPass = !_obscureNewPass;
                          });
                        },
                      )
                    : null,
              ),

              gapH24,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    txt: "Forgot Password",
                    color: blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ],
              ),
              gapH64,
              gapH32,

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  isChecked: _isOtpFilled,
                  text: "Sign In",
                  backgroundColor: _isFormFilled ? blueColor : inactiveColor,
                  borderColor: blueColor,
                  textColor: Colors.white,
                  onPressed: _isFormFilled
                      ? () {
                          debugPrint("Sign In pressed");
                        }
                      : null,
                ),
              ),

              gapH32,

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: blueColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
