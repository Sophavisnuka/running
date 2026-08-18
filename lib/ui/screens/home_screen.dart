import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: const Text('Hello, Sophavisnuka', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}