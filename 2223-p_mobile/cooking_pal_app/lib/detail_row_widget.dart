
import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final Icon icon;
  final String text;
  const DetailRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
