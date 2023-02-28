
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)),
      child: DropdownButton<String>(
        key: const ValueKey('dropdown'),
        items: ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Teatime']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        value: context.watch<FormModel>().mealType,
        onChanged: (value) {
          context.read<FormModel>().setMealType(value!);
        },
      ),
    );
  }
}