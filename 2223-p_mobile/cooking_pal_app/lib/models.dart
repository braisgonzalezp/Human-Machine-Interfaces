
import 'package:flutter/material.dart';
import 'package:stack/stack.dart' as Stack1;


/* ======================================MODELS====================================== */

class FormModel extends ChangeNotifier {
  var ingredient = '';
  var mealType = 'Breakfast';

  void setIngredient(String value) {
    ingredient = value;
    notifyListeners();
  }

  void setMealType(String value) {
    mealType = value;
    notifyListeners();
  }

  bool isEmptyIngredient(){
    return ingredient == '';
  }
}

class RecipeModel extends ChangeNotifier {
  var recipeBlock;
  var stack = Stack1.Stack<String>();
  String nextBlock = '';

  void setNextBlock() {
    if (recipeBlock.nextBlock != null || recipeBlock.nextBlock != '') {
      stack.push(recipeBlock.actualBlock);
      nextBlock = recipeBlock.nextBlock;
    } else {
      nextBlock = '';
    }
    notifyListeners();
  }

  void setPreviousBlock() {
    if (stack.isNotEmpty) {
      nextBlock = stack.pop();
    }
    notifyListeners();
  }

  void setRecipeBlock(var value) {
    recipeBlock = value;
    nextBlock = '';
    notifyListeners();
  }

  void setRecipeBlockNoNotify(var value) {
    recipeBlock = value;
    nextBlock = '';
  }

  void clearStack() {
    for (int i = 0; i < stack.size(); i++) {
      if (stack.isNotEmpty) {
        stack.pop();
      }
    }
    notifyListeners();
  }
}

class InfoModel extends ChangeNotifier {
  List<bool> expanded = [false, false, false, false, false];

  void setExpanded(bool expanded, int i) {
    this.expanded[i] = expanded;
    notifyListeners();
  }

  void restartExpanders() {
    for(int i = 0; i < expanded.length; i++){
      expanded[i] = false;
    }
    notifyListeners();
  }
}

class TabletModel extends ChangeNotifier {

  bool isTablet = false;
  bool startSearch = false;


  void setIsTablet(bool isTablet){
    this.isTablet = isTablet;
  }

  void setStartSearch(bool startSearch){
    this.startSearch = startSearch;
    notifyListeners();
  }


}