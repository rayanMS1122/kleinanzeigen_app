import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import '../screens/main_screen.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // Start background animation
    _backgroundController.forward();
    
    // Start logo animation after a short delay
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    
    // Start text animation
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
    
    // Navigate to main screen after all animations
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.theme.primaryColor,
              context.theme.primaryColor.withOpacity(0.8),
              context.theme.primaryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(20, (index) => _buildFloatingParticle(index)),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animation
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoController.value,
                        child: Transform.rotate(
                          angle: _logoController.value * 0.5,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.storefront_rounded,
                              size: 60,
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // App name animation
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textController.value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - _textController.value)),
                          child: Column(
                            children: [
                              Text(
                                'Kleinanzeigen',
                                style: context.textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kaufen • Verkaufen • Entdecken',
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Loading indicator
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                      strokeWidth: 3,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: 1000.ms),
                ],
              ),
            ),
            
            // Bottom branding
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Powered by Flutter',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => 
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ).animate(delay: (index * 200).ms)
                          .fadeIn(duration: 600.ms)
                          .then(delay: 400.ms)
                          .fadeOut(duration: 600.ms)
                          .then()
                          .fadeIn(duration: 600.ms),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 1000.ms, delay: 1000.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingParticle(int index) {
    final random = (index * 37) % 100;
    final size = 4.0 + (random % 8);
    final left = (random * 3.7) % MediaQuery.of(context).size.width;
    final animationDelay = (random * 50) % 2000;
    
    return Positioned(
      left: left,
      top: -20,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ).animate(onPlay: (controller) => controller.repeat())
          .moveY(
            begin: -20,
            end: MediaQuery.of(context).size.height + 20,
            duration: Duration(milliseconds: 3000 + (random % 2000)),
            delay: Duration(milliseconds: animationDelay),
          )
          .fadeIn(duration: 500.ms)
          .then(delay: 2000.ms)
          .fadeOut(duration: 500.ms),
    );
  }
}

