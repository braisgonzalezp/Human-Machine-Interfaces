// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:cooking_pal_app/main_app.dart';
import 'package:provider/provider.dart';
import 'models.dart';

void main() {

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FormModel()),
      ChangeNotifierProvider(create: (_) => RecipeModel()),
      ChangeNotifierProvider(create: (_) => InfoModel()),
      ChangeNotifierProvider(create: (_) => TabletModel()),
      ],
      child: const RecipeApp(),
    )
  );

}
