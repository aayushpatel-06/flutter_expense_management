import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFEAFBF4), Color(0xFFBDF0D8)],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 52.0, right: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "v1.0",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(10, 80, 55, 0.45),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 90, width: double.infinity),

          Center(
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 180, 110, 0.10),
                border: Border.all(
                  color: Color.fromRGBO(0, 180, 110, 0.30),
                  width: 1.5,
                ),
              ),
              child: Image.asset(
                'assets/images/cash-flow.png',
                height: 62,
                width: 62,
                fit: BoxFit.cover,
                color: const Color(0xFF00A86B),
              ),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            "FinTrack",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Color(0xFF0A3D2A),
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              "\"See your spending.\nShape your saving.\"",
              style: TextStyle(
                fontSize: 18,
                height: 1.55,
                color: Color.fromRGBO(10, 60, 40, 0.55),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 120, width: double.infinity),

          SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A86B)),
              backgroundColor: Color.fromRGBO(0, 180, 110, 0.15),
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              "Loading...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(10, 60, 40, 0.45),
                letterSpacing: 1.8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Text(
              "Copyright © 2026. All Rights Reserved.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(10, 60, 40, 0.35),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}