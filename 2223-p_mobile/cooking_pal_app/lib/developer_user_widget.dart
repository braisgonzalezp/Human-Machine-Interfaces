
import 'package:flutter/material.dart';

class DeveloperUserWidget extends StatelessWidget {
  final String photo;
  final String name;
  final String text;

  const DeveloperUserWidget(
      {super.key, required this.photo, required this.name, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(1, 1), // 10% of the width, so there are ten blinds.
          colors: <Color>[
            Color.fromARGB(160, 255, 255, 255),
            Color.fromARGB(164, 255, 255, 255),
          ], // red to yellow
          // repeats the gradient over the canvas
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListTile(
              leading: SizedBox(
                width: 55,
                height: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image(image: AssetImage(photo), height: 55)),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                text,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}