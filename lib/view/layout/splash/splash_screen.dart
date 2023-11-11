import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/theme/app_text_style.dart';
import '../../custom_widgets/page_container/page_container.dart';
import '../auth/controller/auth_controller.dart';
import '../auth/screen/login_screen.dart';
import '../wallpaper/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final controller = context.read<AuthController>();
      controller.initial();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          if (controller.user != null) {
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.routeName,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              LoginScreen.routeName,
            );
          }
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PageContainer(
      child: Scaffold(
        body: Center(
          child: Text(
            "Splash",
            style: AppTextStyle.textD16B,
          ),
        ),
      ),
    );
  }
}
