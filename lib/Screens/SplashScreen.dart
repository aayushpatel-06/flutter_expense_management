import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/list');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFF0B0617),

              Color(0xFF140824),

              Color(0xFF1E0D3A),

              Color(0xFF102B4E),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: Column(
              children: [
                const Spacer(),

                // LOGO
                Container(
                  height: 118,
                  width: 118,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [Color(0xFFCA6CFF), Color(0xFF8A3DFF)],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB14EFF).withValues(alpha: 0.22),

                        blurRadius: 35,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(28),

                    child: Image.asset(
                      'assets/images/cash-flow.png',

                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 46),

                // APP NAME
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Colors.white, Color(0xFFE7CCFF)],
                    ).createShader(bounds);
                  },

                  child: const Text(
                    "TrackEx",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 44,

                      fontWeight: FontWeight.w800,

                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // SUBTITLE
                Text(
                  "Track expenses effortlessly and stay in control of your finances.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),

                    fontSize: 16,

                    height: 1.7,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // LOADER
                SizedBox(
                  height: 34,
                  width: 34,

                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,

                    valueColor: const AlwaysStoppedAnimation(Color(0xFFCA6CFF)),

                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Loading your workspace",

                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.42),

                    fontSize: 14,

                    letterSpacing: 0.4,

                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // COPYRIGHT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),

                  child: Text(
                    "© 2026 TrackEx • All Rights Reserved",

                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.26),

                      fontSize: 12.5,

                      letterSpacing: 0.4,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
