import 'package:go_router/go_router.dart';

// Auth Screens
import 'package:logisticdriverapp/features/authentication/login.dart';
import 'package:logisticdriverapp/features/authentication/register.dart';
import 'package:logisticdriverapp/features/authentication/register_successful.dart';
import 'package:logisticdriverapp/features/authentication/create_password.dart';
import 'package:logisticdriverapp/features/authentication/forgot_password.dart';

// Bottom Navbar
import 'package:logisticdriverapp/features/bottom_navbar/bottom_navbar_screen.dart';

// Splash
import 'package:logisticdriverapp/features/custom_splash/splash.dart';
import 'package:logisticdriverapp/features/home/Profile/Change_password_screen.dart';
import 'package:logisticdriverapp/features/home/Profile/Edit_profile.dart';
import 'package:logisticdriverapp/features/home/Profile/help_support_screen.dart';
import 'package:logisticdriverapp/features/home/Profile/setting_screen.dart';
import 'package:logisticdriverapp/features/home/conform_order_screen.dart';
import 'package:logisticdriverapp/features/home/conform_order_successfull.dart';

// Home Main Screens
import 'package:logisticdriverapp/features/home/map_screen.dart';
import 'package:logisticdriverapp/features/home/notification_screen.dart';
import 'package:logisticdriverapp/features/home/order_successful.dart';
import 'package:logisticdriverapp/features/home/summary_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    // ---------- Splash ----------
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // ---------- Authentication ----------
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const SignUpScreen(),
    ),

    GoRoute(
      path: '/create-password',
      builder: (context, state) => const CreatePasswordScreen(),
    ),
    GoRoute(
      path: '/register-success',
      builder: (context, state) => const RegisterSuccessful(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPassword(),
    ),

    // ---------- Bottom Navbar ----------
    GoRoute(
      path: '/home',
      builder: (context, state) => const TripsBottomNavBarScreen(initialIndex: 0),
    ),

    GoRoute(
      path: '/order-details',
      builder: (context, state) => const TripsBottomNavBarScreen(initialIndex: 1),
    ),

     GoRoute(
      path: '/earning',
      builder: (context, state) => const TripsBottomNavBarScreen(initialIndex: 2),
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) => const TripsBottomNavBarScreen(initialIndex: 3),
    ),

    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/help-support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),

    // ---------- Order Screens ----------
    GoRoute(
      path: '/confirm-order',
      builder: (context, state) => const ConformOrderScreen(),
    ),
    GoRoute(
      path: '/confirm-success',
      builder: (context, state) => const ConformOrderSuccessfull(),
    ),
    GoRoute(
      path: '/order-success',
      builder: (context, state) => const OrderSuccessful(),
    ),
    GoRoute(
      path: '/summary',
      builder: (context, state) => const SummaryScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
  ],
);
