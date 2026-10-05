import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/routes.dart';

class QuickTechSplashPage extends StatefulWidget {
  const QuickTechSplashPage({super.key});

  @override
  State<QuickTechSplashPage> createState() => _QuickTechSplashPageState();
}

class _QuickTechSplashPageState extends State<QuickTechSplashPage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for logo
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Fade animation for text
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animations
    _scaleController.forward();
    _fadeController.forward();

    // Navigate to Login page after splash screen animation
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA).withValues(alpha: 0.8),
              const Color(0xFF764BA2).withValues(alpha: 0.8),
              const Color(0xFFF093FB).withValues(alpha: 0.9),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background shapes
            Positioned(
              top: -100,
              right: -50,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -50,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with scale animation
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Image.asset('assets/logo/earth.png'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // App name with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Go You Travels',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tagline with fade animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Your Journey Awaits',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Column(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 3,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading System...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
