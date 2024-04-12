import 'package:flutter/material.dart';
import 'package:parley/controllers/auth_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              AuthController().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
