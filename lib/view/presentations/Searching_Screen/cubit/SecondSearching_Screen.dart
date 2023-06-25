import 'package:flutter/material.dart';

class SecondSearchingScreen extends StatelessWidget {
  const SecondSearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(child: Text("Second Page")),
      ),
    );
  }
}
