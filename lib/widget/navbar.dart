import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Weather App',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
