// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Page"),
    );
  }
}
