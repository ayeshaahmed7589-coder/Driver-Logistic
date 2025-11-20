import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logisticdriverapp/constants/colors.dart';

import '../../export.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();

  
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    
    emailController.addListener(_checkFormFilled);

  }


  ///  check karega ki dono fields filled hain ya nahi
  void _checkFormFilled() {
    final isFilled =
        emailController.text.isNotEmpty;

    if (isFilled != _isFormFilled) {
      setState(() => _isFormFilled = isFilled);
    }
  }

  // bool isChecked = false;

  @override
  void dispose() {
    emailFocus.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor = AppColors.mediumGray;
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "koovs",
                style: TextStyle(
                  color: AppColors.electricTeal,
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
                  color: AppColors.electricTeal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your Register email\naddress to reset your password",
                style: TextStyle(color: AppColors.mediumGray, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              gapH20,

              CustomAnimatedTextField(
                controller: emailController,
                focusNode: emailFocus,
                labelText: "Email ID",
                hintText: "Email ID",
                prefixIcon: Icons.email_outlined,
                iconColor: AppColors.electricTeal,
                borderColor: AppColors.electricTeal,
                textColor: AppColors.mediumGray,
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
                  isChecked: emailController.text.isNotEmpty,
                  text: "Submit",
                  backgroundColor: emailController.text.isNotEmpty
                      ? AppColors.electricTeal
                      : inactiveColor,
                  borderColor: AppColors.electricTeal,
                  textColor: AppColors.lightGrayBackground,
                  onPressed: emailController.text.isNotEmpty
                      ? () {
                          context.go('/create-password');
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
