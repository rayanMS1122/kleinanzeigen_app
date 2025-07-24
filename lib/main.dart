import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'theme/app_theme.dart';
import 'widgets/animated_splash_screen.dart';

void main() {
  // Set German locale for timeago
  timeago.setLocaleMessages('de', timeago.DeMessages());
  
  runApp(const KleinanzeigenApp());
}

class KleinanzeigenApp extends StatelessWidget {
  const KleinanzeigenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kleinanzeigen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AnimatedSplashScreen(),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

