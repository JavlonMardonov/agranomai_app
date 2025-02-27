import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final VoidCallback onItemSelected;

  const CustomBottomNav({super.key, required this.onItemSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 30),
            onPressed: () => Navigator.pushNamed(context, "/landing"),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
            onPressed: () => onItemSelected,
          ),
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white, size: 30),
            onPressed: () => Navigator.pushNamed(context, "/history"),
          ),
        ],
      ),
    );
  }
}
