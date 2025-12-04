// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../constants/validation_regx.dart';
// import '../../../export.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 🔥 Form key

//   final emailFocus = FocusNode();
//   final passwordFocus = FocusNode();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController PasswordController = TextEditingController();

//   bool _obscureNewPass = true;
//   bool _showNewPassEye = false;
//   bool _isFormFilled = false;

//   @override
//   void initState() {
//     super.initState();
//     PasswordController.addListener(_passwordListener);
//     emailController.addListener(_checkFormFilled);
//     PasswordController.addListener(_checkFormFilled);
//   }

//   void _passwordListener() {
//     final shouldShow = PasswordController.text.isNotEmpty;
//     if (shouldShow != _showNewPassEye) {
//       setState(() => _showNewPassEye = shouldShow);
//     }
//   }

//   void _checkFormFilled() {
//     // dono fields me kuch likha hai ya nahi
//     final isFilled =
//         emailController.text.isNotEmpty && PasswordController.text.isNotEmpty;

//     // dono fields ka validation pass hua ya nahi
//     final isValid =
//         AppValidators.email(emailController.text) == null &&
//         AppValidators.password(PasswordController.text) == null;

//     final enableButton = isFilled && isValid;

//     if (enableButton != _isFormFilled) {
//       setState(() => _isFormFilled = enableButton);
//     }
//   }

//   @override
//   void dispose() {
//     emailFocus.dispose();
//     passwordFocus.dispose();
//     emailController.dispose();
//     PasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color inactiveColor = AppColors.mediumGray;
//     return Scaffold(
//       backgroundColor: AppColors.lightGrayBackground,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//           child: Form(
//             key: _formKey, // 🔥 Entire form wrapped
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "DROVVI",
//                   style: TextStyle(
//                     color: AppColors.electricTeal,
//                     fontSize: 50,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 gapH32,
//                 Text(
//                   "Welcome Back",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.electricTeal,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Please enter your email id or password to Sign In.",
//                   style: TextStyle(color: AppColors.mediumGray, fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//                 gapH20,

//                 // ---------------- EMAIL FIELD ----------------
//                 CustomAnimatedTextField(
//                   controller: emailController,
//                   focusNode: emailFocus,
//                   labelText: "Email ID",
//                   hintText: "Email ID",
//                   prefixIcon: Icons.email_outlined,
//                   iconColor: AppColors.electricTeal,
//                   borderColor: AppColors.electricTeal,
//                   textColor: AppColors.mediumGray,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: AppValidators.email, // 🔥 VALIDATION APPLIED
//                 ),
//                 gapH8,

//                 // ---------------- PASSWORD FIELD ----------------
//                 CustomAnimatedTextField(
//                   controller: PasswordController,
//                   focusNode: passwordFocus,
//                   labelText: "Password",
//                   hintText: "Password",
//                   prefixIcon: Icons.lock_outline,
//                   iconColor: AppColors.electricTeal,
//                   borderColor: AppColors.electricTeal,
//                   textColor: AppColors.mediumGray,
//                   obscureText: _obscureNewPass,
//                   validator: AppValidators.password, // 🔥 VALIDATION APPLIED
//                   suffixIcon: _showNewPassEye
//                       ? IconButton(
//                           icon: Icon(
//                             _obscureNewPass
//                                 ? Icons.visibility_off_outlined
//                                 : Icons.visibility_outlined,
//                             color: Colors.black,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureNewPass = !_obscureNewPass;
//                             });
//                           },
//                         )
//                       : null,
//                 ),

// gapH24,
// Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     GestureDetector(
//       onTap: () {
//         context.go("/forgot-password");
//       },
//       child: CustomText(
//         txt: "Forgot Password",
//         color: AppColors.electricTeal,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//     ),
//   ],
// ),
// gapH64,
// gapH32,

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: CustomButton(
//                     isChecked: _isFormFilled,
//                     text: "Sign In",
//                     backgroundColor: _isFormFilled
//                         ? AppColors.electricTeal
//                         : inactiveColor,
//                     borderColor: AppColors.electricTeal,
//                     textColor: AppColors.lightGrayBackground,
//                     onPressed: _isFormFilled
//                         ? () {
//                             if (_formKey.currentState!.validate()) {
//                               context.go("/home"); // ✅ Only when form valid
//                             }
//                           }
//                         : null,
//                   ),
//                 ),

//                 gapH32,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/validation_regx.dart';
import '../../../export.dart';
import 'login_controller.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _showEye = false;
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_passwordListener);
    emailController.addListener(_checkFormFilled);
    passwordController.addListener(_checkFormFilled);
  }

  void _passwordListener() {
    setState(() => _showEye = passwordController.text.isNotEmpty);
  }

  void _checkFormFilled() {
    final isFilled =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    final isValid =
        AppValidators.email(emailController.text) == null &&
        AppValidators.password(passwordController.text) == null;
    setState(() => _isFormFilled = isFilled && isValid);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final Color inactiveColor = AppColors.mediumGray;

    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DROVVI",
                  style: TextStyle(
                    color: AppColors.electricTeal,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gapH32,
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
                  validator: AppValidators.email, // 🔥 VALIDATION APPLIED
                ),
                gapH12,
                // ---------------- PASSWORD FIELD ----------------
                CustomAnimatedTextField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  labelText: "Password",
                  hintText: "Password",
                  prefixIcon: Icons.lock_outline,
                  iconColor: AppColors.electricTeal,
                  borderColor: AppColors.electricTeal,
                  textColor: AppColors.mediumGray,
                  obscureText: _obscurePassword,
                  validator: AppValidators.password, // 🔥 VALIDATION APPLIED
                  suffixIcon: _showEye
                      ? IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        )
                      : null,
                ),

                gapH24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go("/forgot-password");
                      },
                      child: CustomText(
                        txt: "Forgot Password",
                        color: AppColors.electricTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                gapH32,
                CustomButton(
                  isChecked: _isFormFilled,
                  text: state is AsyncLoading ? "Signing In..." : "Sign In",
                  backgroundColor: _isFormFilled
                      ? AppColors.electricTeal
                      : inactiveColor,
                  borderColor: AppColors.electricTeal,
                  textColor: AppColors.lightGrayBackground,
                  onPressed: _isFormFilled
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            await ref
                                .read(loginControllerProvider.notifier)
                                .login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );

                            final loginState = ref.read(
                              loginControllerProvider,
                            );
                            if (loginState is AsyncData &&
                                loginState.value != null) {
                              context.go("/home"); // Navigate to home
                            } else if (loginState is AsyncError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Invalid email or password"),
                                ),
                              );
                            }
                          }
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
