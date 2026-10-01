import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/colors/app_colors.dart';
import '../../view_models/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final controller = Get.put(SplashController());

  late AnimationController _mainController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  late AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutBack),
    );

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.gradientStart,
              AppColor.gradientEnd,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Watermark Icons
            Positioned(
              top: 50,
              right: -50,
              child: _buildWatermarkIcon(Icons.build_rounded, 250, 0.4),
            ),
            Positioned(
              bottom: 100,
              left: -60,
              child: _buildWatermarkIcon(Icons.build_rounded, 300, -0.3),
            ),

            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Icon Box
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.build_rounded,
                          color: AppColor.primary,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // App Name
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Skill',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: 'Link',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        'Services at your doorstep',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.textSecondary,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Loading Dots
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _dotController,
                builder: (context, child) {
                  int activeDot = (_dotController.value * 3).floor();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return _buildDot(i == activeDot);
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatermarkIcon(IconData icon, double size, double rotate) {
    return Opacity(
      opacity: 0.06,
      child: Transform.rotate(
        angle: rotate,
        child: Icon(icon, size: size, color: Colors.white),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColor.primary : AppColor.grey400.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
