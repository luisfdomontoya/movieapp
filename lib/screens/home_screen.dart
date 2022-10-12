import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies at theater'),
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
