import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3E5F5),
              Color(0xFFF8F7FC),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating card decorations
            Positioned(
              top: 120,
              left: 35,
              child: _buildFloatingCard(0.08, 18),
            ),
            Positioned(
              top: 200,
              right: 45,
              child: _buildFloatingCard(0.06, -15),
            ),
            Positioned(
              bottom: 220,
              left: 55,
              child: _buildFloatingCard(0.1, 22),
            ),
            Positioned(
              bottom: 300,
              right: 35,
              child: _buildFloatingCard(0.07, -20),
            ),
            
            // Main content
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withOpacity(0.15),
                              blurRadius: 35,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Back card
                            Positioned(
                              top: 22,
                              child: Transform.rotate(
                                angle: -0.1,
                                child: Container(
                                  width: 62,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE1BEE7),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                            ),
                            // Middle card
                            Positioned(
                              top: 30,
                              child: Container(
                                width: 62,
                                height: 46,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFBA68C8), Color(0xFFAB47BC)],
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                            ),
                            // Front card
                            Positioned(
                              top: 40,
                              child: Container(
                                width: 62,
                                height: 46,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF8B5CF6).withOpacity(0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.bolt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 28),
                      
                      // App name
                      const Text(
                        'FlashLearn',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A3A52),
                          letterSpacing: -0.3,
                        ),
                      ),
                      
                      const SizedBox(height: 70),
                      
                      // Loading indicator
                      const SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.8,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFA78BFA)),
                        ),
                      ),
                      
                      const SizedBox(height: 14),
                      
                      // Loading text
                      Text(
                        'Preparing your flashcards…',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: const Color(0xFF1A3A52).withOpacity(0.55),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCard(double opacity, double rotation) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: 78,
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFFA78BFA).withOpacity(opacity),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: const Color(0xFFA78BFA).withOpacity(opacity * 1.3),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
