
import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final info;
  final length;
  const ListData({super.key, required this.info, required this.length});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        itemCount: length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '\t· ${info[index]}',
              style: const TextStyle(fontSize: 15),
            ),
          );
        },
      ),
    );
  }
}