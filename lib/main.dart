import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Flutter App',
      home: const BasicHomePage(),
    );
  }
}

class BasicHomePage extends StatelessWidget {
  const BasicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Flutter App'),
      ),
      body: const Center(
        child: Text('Step one'),
      ),
    );
  }
}

