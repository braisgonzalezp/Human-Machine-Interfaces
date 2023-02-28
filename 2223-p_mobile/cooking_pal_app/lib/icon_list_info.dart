import 'package:flutter/material.dart';

class IconListInfo extends StatelessWidget {

  final recipe;
  const IconListInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    var glycemicIndex;
    if (recipe.glycemicIndex == null) {
      glycemicIndex = '-';
    } else {
      glycemicIndex = recipe.glycemicIndex.toString();
    }
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.kitchen, color: Colors.green[500]),
              const Text('PREP:'),
              Text('${recipe.totalTime} mins'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.restaurant, color: Colors.green[500]),
              const Text('FEEDS:'),
              Text(recipe.servings.toStringAsFixed(0)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.fastfood_outlined,
                  color: Colors.green[500]),
              const Text('CAL:'),
              Text(recipe.calories.toStringAsFixed(0)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.co2, color: Colors.green[500]),
              const Text('EMIS:'),
              Text(recipe.totalCO2Emissions.toStringAsFixed(0)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.co2_sharp, color: Colors.green[500]),
              const Text('CLASS:'),
              Text(recipe.co2EmissionsClass),
            ],
          ),
          Column(
            children: [
              Icon(Icons.pie_chart_outline_sharp, color: Colors.green[500]),
              const Text('GI:'),
              Text(glycemicIndex),
            ],
          ),
        ],
      ),
    );
  }
}