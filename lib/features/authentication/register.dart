import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logisticdriverapp/common_widgets/cuntom_textfield.dart';
import 'package:logisticdriverapp/common_widgets/custom_button.dart';
import 'package:logisticdriverapp/constants/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailFocus = FocusNode();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  bool isChecked = false;

  final Color blueColor = const Color(0xFF345CFF);

  @override
  void dispose() {
    _focusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 40),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your Email ID to Sign Up.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

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

              const SizedBox(height: 40),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (val) =>
                        setState(() => isChecked = val ?? false),
                    activeColor: blueColor,
                    side: BorderSide(color: blueColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  Expanded(
                    child: Wrap(
                      children: [
                        const Text(
                          "By continuing, I confirm that I have read the ",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          "Terms of Use",
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Text(
                          " and ",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              gapH64,
              gapH48,

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  isChecked: isChecked,
                  text: "Sign Up",
                  backgroundColor: blueColor,
                  borderColor: blueColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 30),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a Koovs Member? ",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
