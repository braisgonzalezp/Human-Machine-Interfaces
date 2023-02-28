
import 'package:flutter/material.dart';
import 'icon_list_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'list_data_widget.dart';
import 'expanded_info_widget.dart';

class DetailsWidget extends StatelessWidget {

  final recipe;
  const DetailsWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 1,
            ),
            child: Container(
              alignment: Alignment.center,
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.image),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: IconListInfo(recipe: recipe,),
          ),
          //============MEAL TYPE============
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Meal type for this recipe: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: ListData(
              info: recipe.mealType,
              length: recipe.mealType.length,
            ),
          ),
          //============DISH TYPE============
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Dish type for this recipe: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: ListData(
              info: recipe.dishType,
              length: recipe.dishType.length,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Cuisine type for this recipe: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: ListData(
              info: recipe.cuisineType,
              length: recipe.cuisineType.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Ingredients for this recipe: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
            ),
            child: ListData(
              info: recipe.ingredients,
              length: recipe.ingredients.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: ExpandedInfoWidget(
              info: recipe.cautions,
              title: 'Cautions',
              expandedPanel: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: ExpandedInfoWidget(
              info: recipe.dietLabels,
              title: 'Diet Labels',
              expandedPanel: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: ExpandedInfoWidget(
              info: recipe.healthLabels,
              title: 'Health Labels',
              expandedPanel: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: ExpandedInfoWidget(
              info: recipe.totalNutrients,
              title: 'Total Nutrients',
              expandedPanel: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: ExpandedInfoWidget(
              info: recipe.totalDaily,
              title: 'Total Daily Nutrients',
              expandedPanel: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
              right: 20,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'For more information, go to ${recipe.source} web site for this recipe:',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: ElevatedButton(

              onPressed: () {
                Uri uri = Uri.parse(recipe.sourceUrl);
                launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff052030),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle:
                  const TextStyle(fontSize: 15)
              ),
              child: Text(
                  '${recipe.source} web site',
                  style: const TextStyle(
                    color: Colors.white,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}