import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parley/screens/auth/signUp_view.dart';

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
      ), () {
        Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) => const SignUpView()));
      }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}