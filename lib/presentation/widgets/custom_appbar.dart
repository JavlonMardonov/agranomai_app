
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundImage:
                NetworkImage("https://randomuser.me/api/portraits/men/45.jpg"),
          ),
          const SizedBox(width: 10),
          RichText(
            text: const TextSpan(
              text: "Xush kelibsiz,\n",
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: "Samuel Joe",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
