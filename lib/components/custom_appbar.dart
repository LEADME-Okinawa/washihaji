import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/header_logo.png',
        height: 40,
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFFB1D6B5),
      foregroundColor: const Color(0xFF343A40),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
