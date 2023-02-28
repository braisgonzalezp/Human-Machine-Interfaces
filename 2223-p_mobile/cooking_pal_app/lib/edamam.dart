import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

const API_URL = "api.edamam.com";
const ENDPOINT = "api/recipes/v2";
const TYPE = "public";
const APP_ID = "49e40031";
const APP_KEY = "d86f65510ebd56cba348b6da994b9471";

class Nutrient {
  String label;
  double value;
  Nutrient(this.label, this.value);
  @override
  String toString() {
    if(value == 0) {
      return "\t\tNutrient: $label: -\n";
    } else {
      const nutrientUnits = {
        'Energy' : 'cal',
        'Fat' : 'g',
        'Saturated' : 'g',
        'Trans' : 'g',
        'Monounsaturated' : 'g',
        'Polyunsaturated' : 'g',
        'Carbs' : 'g',
        'Carbohydrates (net)' : 'g',
        'Fiber' : 'g',
        'Sugars' : 'g',
        'Sugars, added' : 'g',
        'Protein' : 'g',
        'Cholesterol' : 'mg',
        'Sodium' : 'mg',
        'Calcium' : 'mg',
        'Magnesium' : 'mg',
        'Potassium' : 'mg',
        'Iron' : 'mg',
        'Zinc' : 'mg',
        'Phosphorus' : 'mg',
        'Vitamin A' : 'µg',
        'Vitamin C' : 'mg',
        'Thiamin (B1)' : 'mg',
        'Riboflavin (B2)' : 'mg',
        'Niacin (B3)' : 'mg',
        'Vitamin B6' : 'mg',
        'Folate equivalent (total)' : 'µg',
        'Folate (food)' : 'µg',
        'Folic acid' : 'µg',
        'Vitamin B12' : 'µg',
        'Vitamin D' : 'µg',
        'Vitamin E' : 'mg',
        'Vitamin K' : 'µg',
        'Sugar alcohol' : 'g',
        'Water' : 'g',
      };
      return "\t\tNutrient: $label: ${value.toStringAsFixed(2)} ${nutrientUnits[label]}\n";
    }
  }
}

class Recipe {
  String? uri;
  String? label;
  String? image;
  String? thumbnail;
  String? source;
  String? sourceUrl;
  double? servings;
  List<String>? healthLabels;
  List<String>? dietLabels;
  List<String>? cautions;
  List<String>? ingredients;
  double? calories;
  double? glycemicIndex;
  double? totalCO2Emissions;
  String? co2EmissionsClass;
  double? totalTime;
  List<String>? cuisineType;
  List<String>? mealType;
  List<String>? dishType;
  List<Nutrient>? totalNutrients;
  List<Nutrient>? totalDaily;

  Recipe(
      {this.uri,
       this.label,            //PUESTO
      this.image,             //PUESTO
      this.thumbnail,         //PUESTO
      this.source,            //PUESTO
      this.sourceUrl,         //PUESTO
      this.servings,          //PUESTO
      this.healthLabels,      //PUESTO
      this.dietLabels,        //PUESTO
      this.cautions,          //PUESTO
      this.ingredients,       //PUESTO
      this.calories,          //PUESTO
      this.glycemicIndex,     //PUESTO
      this.totalCO2Emissions, //PUESTO
      this.co2EmissionsClass, //PUESTO
      this.totalTime,         //PUESTO
      this.cuisineType,       //PUESTO
      this.mealType,          //PUESTO
      this.dishType,          //PUESTO
      this.totalNutrients,    //PUESTO
      this.totalDaily         //PUESTO
      });

  @override
  String toString() {
    return "Recipe: \n" +
        "\tUri: $uri\n" +
        "\tLabel: $label\n" +
        "\tSource: $source\n" +
        "\tSourceUrl: $sourceUrl\n" +
        "\tServings: $servings\n" +
        "\tHealthLabels: $healthLabels\n" +
        "\tDietLabels: $dietLabels\n" +
        "\tCautions: $cautions\n" +
        "\tIngredients: $ingredients\n" +
        "\tCalories: $calories\n" +
        "\tGlycemicIndex: $glycemicIndex\n" +
        "\tTotalCO2Emissions: $totalCO2Emissions\n" +
        "\tCo2EmissionsClass: $co2EmissionsClass\n" +
        "\tTotalTime: $totalTime\n" +
        "\tCuisineType: $cuisineType\n" +
        "\tMealType: $mealType\n" +
        "\tDishType: $dishType\n" +
        "\tTotalNutrients: \n$totalNutrients\n" +
        "\tTotalDaily: \n$totalDaily\n";
  }
}

class RecipeBlock {
  int from;
  int to;
  int count;
  String? nextBlock;
  String actualBlock;
  List<Recipe>? recipes;

  RecipeBlock(
      {required this.from,
      required this.to,
      required this.count,
      required this.actualBlock,
      this.nextBlock,
      this.recipes});

  @override
  String toString() {
    return "RecipeBlock: From: $from | To: $to | Count: $count\n" +
        "$recipes\n" +
        "NextBlock: $nextBlock";
  }
}

class FormatException implements Exception {
  final List<String> msg;
  const FormatException(this.msg);
  @override
  String toString() => "FormatException: $msg";
}

List<String>? parse_list(var list) =>
    list != null ? List<String>.from(list) : null;

Future<RecipeBlock?> search_recipes(String query, String mealType, String next) async {
  // TODO: include a search criteria!
  var formattedQuery =
      "type=$TYPE&beta=true&app_id=$APP_ID&app_key=$APP_KEY&q=$query&mealType=$mealType";

  var uri;
  if(next != '') {
    uri = Uri.parse(next);
  } else {
    uri = Uri(
        scheme: "https", host: API_URL, path: ENDPOINT, query: formattedQuery);
  }

  var response = await http.get(uri);
  var data = jsonDecode(response.body);

  if (response.statusCode != 200) {
    List<String> errors = [];
    if (data is List) {
      for (var element in data) {
        errors.add("${element["message"]} ${element["params"]}");
      }
    } else {
      errors.add("${data["message"]} ${data["params"]}");
    }
    throw FormatException(errors);
  }

  RecipeBlock block;

  if (data['count'] == 0) {
    block = RecipeBlock(from: 0, to: 0, count: 0, actualBlock: uri.toString());
  } else {
    List<Recipe> recipes = [];

    for (var hit in data["hits"]) {
      var recipe = hit["recipe"];
      List<Nutrient> totalNutrients = [];
      recipe["totalNutrients"]?.forEach((key, value) {
        totalNutrients.add(Nutrient(value["label"], value["quantity"]));
      });

      List<Nutrient> totalDaily = [];
      recipe["totalDaily"]?.forEach((key, value) {
        totalDaily.add(Nutrient(value["label"], value["quantity"]));
      });

      recipes.add(Recipe(
          uri: recipe["uri"],
          label: recipe["label"],
          image: recipe["image"],
          thumbnail: recipe["images"]["THUMBNAIL"]["url"],
          source: recipe["source"],
          sourceUrl: recipe["url"],
          servings: recipe["yield"],
          dietLabels: parse_list(recipe["dietLabels"]),
          healthLabels: parse_list(recipe["healthLabels"]),
          cautions: parse_list(recipe["cautions"]),
          ingredients: parse_list(recipe["ingredientLines"]),
          calories: recipe["calories"],
          glycemicIndex: recipe["glycemicIndex"],
          totalCO2Emissions: recipe["totalCO2Emissions"],
          co2EmissionsClass: recipe["co2EmissionsClass"],
          totalTime: recipe["totalTime"],
          cuisineType: parse_list(recipe["cuisineType"]),
          mealType: parse_list(recipe["mealType"]),
          dishType: parse_list(recipe["dishType"]),
          totalNutrients: totalNutrients,
          totalDaily: totalDaily));
    }

    if(data["to"] == data["count"]){
      block = RecipeBlock(
          from: data["from"],
          to: data["to"],
          count: data["count"],
          actualBlock: uri.toString(),
          recipes: recipes);
    } else {
      block = RecipeBlock(
          from: data["from"],
          to: data["to"],
          count: data["count"],
          actualBlock: uri.toString(),
          nextBlock: data["_links"]["next"]["href"],
          recipes: recipes);
    }
  }
  return block;
}

void main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.length < 2) {
    print("Usage: dart edamam.dart search_string mealType_string");
  } else {
    try {
      var block = await search_recipes(arguments[0], arguments[1],'');
      print(block);
    } catch (exception) {
      print(exception);
    }
  }
}
