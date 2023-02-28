
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';


class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    var count = context.watch<RecipeModel>().recipeBlock.count;
    var from = context.watch<RecipeModel>().recipeBlock.from;
    var to = context.watch<RecipeModel>().recipeBlock.to;
    if (count < 20) {
      return Container(
        padding: const EdgeInsets.only(
          top:20,
          left: 40,
          right: 40,
        ),
        height: 75,
        width: 75,
        child: const Text(
          'No more recipes...',
          style: TextStyle(
            fontFamily: 'HarlandRoselyn',
            fontSize: 35,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      if (from == 1) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<RecipeModel>().setNextBlock();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff052030),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ],
        );
      } else {
        if (count == to) {
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RecipeModel>().setPreviousBlock();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff052030),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RecipeModel>().setPreviousBlock();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff052030),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  child: const Text('Previous',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RecipeModel>().setNextBlock();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff052030),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  child: const Text('Next',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            ],
          );
        }
      }
    }
  }
}