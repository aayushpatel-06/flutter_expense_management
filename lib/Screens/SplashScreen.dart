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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4F7F0), Color(0xFFAAE8D0), Color(0xFF66CCB0)],
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
                    color: Color.fromRGBO(7, 51, 35, 0.447),
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
                color: Color.fromRGBO(0, 203, 125, 0.098),
                border: Border.all(
                  color: const Color.fromARGB(135, 0, 145, 92),
                  width: 3,
                ),
              ),
              child: Image.asset(
                'assets/images/cash-flow.png',
                height: 62,
                width: 62,
                fit: BoxFit.cover,
                color: const Color.fromARGB(249, 0, 161, 102),
              ),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            "TrackEx",
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
