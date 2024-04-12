import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parley/controllers/auth_controller.dart';
import 'package:parley/screens/auth/login_view.dart';
import 'package:parley/screens/auth/signUp_view.dart';
import 'package:parley/screens/home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 1
      ), () async {
      await AuthController().checkAuth();
      if (AuthController().userData == null) {
        Get.offAll(const LoginView());
      } else {
        Get.offAll(const HomeView());
      }
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}