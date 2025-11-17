import 'package:flutter/material.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/bottom_navbar/bottom_navbar_screen.dart';
import 'package:logisticdriverapp/features/routes/app_routes.dart';
import 'export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Logistic Driver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A56DB),
          elevation: 0,
        ),

      ),
      // home: TripsHomePage(),
           home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor:AppColors.electricTeal,
          statusBarBrightness: Brightness.light, // For Android
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: Colors.white, // Navigation bar color
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        // child:Login(),
        child:  TripsBottomNavBarScreen(initialIndex: 0),
      ),
      // home: TripsBottomNavBarScreen(initialIndex: 0),
      //  routerConfig: router,
    );
  }
}
