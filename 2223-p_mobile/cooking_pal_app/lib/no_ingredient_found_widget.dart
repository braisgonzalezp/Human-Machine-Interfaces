
import 'package:flutter/material.dart';

class NoIngredientFoundWidget extends StatelessWidget {
  const NoIngredientFoundWidget({super.key});


  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Image.asset('assets/noencontrado.png'),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Text(
            'NO RECIPES FOUND.\n\nTRY AGAIN.',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}