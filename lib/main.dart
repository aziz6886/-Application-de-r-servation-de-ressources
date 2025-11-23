import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resource Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const PlaceholderStartPage(), // temporary page
    );
  }
}

class PlaceholderStartPage extends StatelessWidget {
  const PlaceholderStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to Resource Booking App",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
