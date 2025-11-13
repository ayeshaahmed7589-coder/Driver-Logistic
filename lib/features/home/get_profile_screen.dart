import 'package:flutter/material.dart';
import 'package:logisticdriverapp/constants/gap.dart';

class GetProfileScreen extends StatelessWidget {
  const GetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color blueColor = const Color(0xFF345CFF);
    // Screen height ka hisaab lagana zaroori hai is layout ke liye
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: primaryBlue,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: blueColor,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.logout, color: Colors.white, size: 28),
          ),
        ],
      ),
      // *** Yahan Body Structure Change Kiya Hai ***
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(height: 150, color: blueColor),

                Positioned(
                  top: screenHeight * 0.1,
                  left: 20,
                  right: 20,
                  bottom: 95,
                  child: _buildInfoCard(),
                ),

                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      _buildProfileImage(blueColor),
                      const SizedBox(height: 15),
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 8),
                        height: 1,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Profile Image Widget ---
  Widget _buildProfileImage(Color primaryBlue) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const CircleAvatar(
          radius: 60,
          // Yahan apni image ka path dena hoga
          backgroundImage: AssetImage('assets/profile_pic.png'),
          backgroundColor: Colors.blue,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: primaryBlue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.edit, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  // --- Info Card Widget (Aapka White Container) ---
  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      // Card ka top rounded corner yahan define kiya
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),

          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        25,
        60,
        25,
        50,
      ), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          gapH64,
          const Text(
            'Personal Info',
            style: TextStyle(
              color: Color(0xFF283593), 
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),

          // Data Rows... (Yeh pehle jaisa hi rahega)
          _buildInfoRow(
            label: 'DOB',
            value: '12/04/1990',
            showVerification: false,
          ),
          const SizedBox(height: 20),

          _buildInfoRow(
            label: 'Mobile Phone',
            value: '(629) 555-0129',
            showVerification: true,
          ),
          const SizedBox(height: 20),

          _buildInfoRow(
            label: 'Email',
            value: 'John@example.com',
            showVerification: false,
            valueColor: Colors.black,
          ),
          const SizedBox(height: 20),

          _buildInfoRow(
            label: 'Employee ID',
            value: '06/06/2021',
            showVerification: false,
          ),
        ],
      ),
    );
  }

  // --- Reusable Info Row Widget (Yeh pehle jaisa hi rahega) ---
  Widget _buildInfoRow({
    required String label,
    required String value,
    required bool showVerification,
    Color labelColor = Colors.grey,
    Color valueColor = const Color(0xFF283593),
  }) {
    // ... (same implementation as before)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 10,),
            if (showVerification)
              const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
                  SizedBox(width: 4),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
