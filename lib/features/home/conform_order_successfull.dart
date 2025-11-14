import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConformOrderSuccessfull extends StatefulWidget {
  const ConformOrderSuccessfull({super.key});

  @override
  State<ConformOrderSuccessfull> createState() =>
      _ConformOrderSuccessfullState();
}

class _ConformOrderSuccessfullState extends State<ConformOrderSuccessfull> {
  @override
  Widget build(BuildContext context) {
    const Color blueColor = Color(0xFF004DEB);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                "assets/Success.json",
                width: 130,
                height: 130,
                fit: BoxFit.contain,
                repeat: false, // optional — play once
                animate: true,
                options: LottieOptions(enableMergePaths: true),
                delegates: LottieDelegates(),
                // 👇 slows down animation
                frameRate: FrameRate(30),
              ),
            ),

            Text(
              "Successful",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Order ",
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
                ),
                Text(
                  "Wo# 004-00-1209",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: blueColor,
                  ),
                ),
              ],
            ),
            Text(
              "has been Confirmed.",
              style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
