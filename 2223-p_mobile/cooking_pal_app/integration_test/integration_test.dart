
import 'package:cooking_pal_app/models.dart';
import 'package:cooking_pal_app/main.dart' as app;
import 'package:cooking_pal_app/main_app.dart';
import 'package:cooking_pal_app/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Introduce an invalid ingredient', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textFormField = find.byType(TextFormField);

    expect(textFormField, findsOneWidget);

    await tester.enterText(textFormField, '');

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final error = find.text("Please enter some ingredient");
    expect(error, findsOneWidget);

  });

  testWidgets('No recipes found in the search', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textFormField = find.byType(TextFormField);

    expect(textFormField, findsOneWidget);

    await tester.enterText(textFormField, 'ricesasesdas');

    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final noRecipes = find.text("NO RECIPES FOUND.\n\nTRY AGAIN.");
    expect(noRecipes, findsOneWidget);

  });

    testWidgets('Look for company information', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('menuButton'));
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final popupMenuItem = find.text("Help");
    expect(popupMenuItem, findsOneWidget);

    await tester.tap(popupMenuItem);
    await tester.pumpAndSettle();

    final company = find.text("Company");
    expect(company, findsOneWidget);

    await tester.tap(company);
    await tester.pumpAndSettle();

    final name = find.text("Raúl Fernández");
    expect(name, findsOneWidget);

  });

  testWidgets('Look for app information', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('menuButton'));
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final popupMenuItem = find.text("Help");
    expect(popupMenuItem, findsOneWidget);

    await tester.tap(popupMenuItem);
    await tester.pumpAndSettle();

    final appInfo = find.text("AppInfo");
    expect(appInfo, findsOneWidget);

    await tester.tap(appInfo);
    await tester.pumpAndSettle();

    final appName = find.text("\n© 2020-2022 The Cooking Pal");
    expect(appName, findsOneWidget);

  });

  testWidgets('Look for privacy information', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final button = find.byKey(const ValueKey('menuButton'));
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final popupMenuItem = find.text("Help");
    expect(popupMenuItem, findsOneWidget);

    await tester.tap(popupMenuItem);
    await tester.pumpAndSettle();

    final privacy = find.text("Privacy");
    expect(privacy, findsOneWidget);

    await tester.tap(privacy);
    await tester.pumpAndSettle();

    final scrollableView = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );
    expect(scrollableView, findsOneWidget);

    final lastItem = find.text("\nInformation We Get from Other Sources");
    await tester.scrollUntilVisible(
      lastItem,
      500.0,
      scrollable: scrollableView,);

    expect(lastItem,findsOneWidget);

  });

  testWidgets(
      'Search for recipes', (tester) async{
    app.main();
    await tester.pumpAndSettle();
    //Meto arroz en la barra de busqueda
    final textFormField = find.byType(TextFormField);
    expect(textFormField, findsOneWidget);

    await tester.enterText(textFormField, 'rice');

    //Pongo dinner en el dropdown
    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown,findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Dinner").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    //Le doy al botón de buscar
    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final scrollableView = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );
    expect(scrollableView, findsOneWidget);

    final lastItem = find.text("Rainbow rice");
    await tester.scrollUntilVisible(
      lastItem,
      500.0,
      scrollable: scrollableView,);

    expect(lastItem,findsOneWidget);

  }
  );


  testWidgets('See recipe details', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    //Meto arroz en la barra de busqueda
    final textFormField = find.byType(TextFormField);
    expect(textFormField, findsOneWidget);

    await tester.enterText(textFormField, 'rice');

    //Pongo dinner en el dropdown
    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown,findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Dinner").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    //Le doy al botón de buscar
    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final ScrollableListView = find.descendant(
      of:find.byType(ListView),
      matching: find.byType(Scrollable),
    );
    expect(ScrollableListView, findsOneWidget);

    final finalItem = find.text("Rainbow rice");
    await tester.scrollUntilVisible(
      finalItem,
      500.0,
      scrollable: ScrollableListView,
    );
    expect(finalItem, findsOneWidget);

    await tester.tap(finalItem);
    await tester.pumpAndSettle();

    final dishType = find.text("\t· main course");
    expect(dishType, findsOneWidget);

    final cuisineType = find.text("\t· american");
    expect(cuisineType, findsOneWidget);

    final listFinder = find.byType(Scrollable);
    final totalNutrients = find.text("Total Nutrients");
    await tester.dragUntilVisible(
        totalNutrients,
        listFinder,
        const Offset(500.0, 0.0)
    );
    expect(totalNutrients, findsOneWidget);


    await tester.tap(find.text("Cautions"));
    await tester.pumpAndSettle();

    final cautions = find.text("\t· Sulfites");
    expect(cautions, findsOneWidget);


  });

  testWidgets(
      'Next and previous buttons', (tester) async{
    app.main();
    await tester.pumpAndSettle();
    //Meto arroz en la barra de busqueda
    final textFormField = find.byType(TextFormField);
    expect(textFormField, findsOneWidget);
    await tester.enterText(textFormField, 'rice');
    //Pongo dinner en el dropdown
    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown,findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Dinner").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    //Le doy al botón de buscar
    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final firstRecipe11 = find.text("Essentials: Rice");
    expect(firstRecipe11, findsOneWidget);

    final scrollableView = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );
    expect(scrollableView, findsOneWidget);

    final nextButton = find.text("Next");
    await tester.scrollUntilVisible(
      nextButton,
      500.0,
      scrollable: scrollableView,);
    expect(nextButton,findsOneWidget);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    final firstRecipe2 = find.text("Rice Pilaf");
    expect(firstRecipe2, findsOneWidget);

    final scrollableView2 = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );

    expect(scrollableView2, findsOneWidget);
    final previousButton = find.text("Previous");

    await tester.scrollUntilVisible(
      previousButton,
      500.0,
      scrollable: scrollableView2,);
    expect(previousButton,findsOneWidget);

    await tester.tap(previousButton);
    await tester.pumpAndSettle();
    final firstRecipe12 = find.text("Essentials: Rice");
    expect(firstRecipe12, findsOneWidget);
  }
  );

  testWidgets(
      'No prev or next buttons', (tester) async{
      app.main();
      await tester.pumpAndSettle();
      final textFormField = find.byType(TextFormField);
      expect(textFormField, findsOneWidget);
      await tester.enterText(textFormField, 'cod');
      //Pongo dinner en el dropdown
      final dropdown = find.byKey(const ValueKey('dropdown'));
      expect(dropdown,findsOneWidget);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      final dropdownItem = find.text("Breakfast").last;
      expect(dropdownItem, findsOneWidget);
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();
      //Le doy al botón de buscar
      final button = find.text("Search");
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pumpAndSettle();

      final scrollableView = find.descendant(
        of: find.byType(ListView),
        matching:find.byType(Scrollable),
      );
      expect(scrollableView, findsOneWidget);

      final noMore = find.text("No more recipes...");
      await tester.scrollUntilVisible(
        noMore,
        500.0,
        scrollable: scrollableView,);
      expect(noMore,findsOneWidget);
      });


  testWidgets(
      'Only prev and next buttons', (tester) async{
    app.main();
    await tester.pumpAndSettle();

    final textFormField = find.byType(TextFormField);
    expect(textFormField, findsOneWidget);
    await tester.enterText(textFormField, 'fajitas');
    //Pongo dinner en el dropdown

    final dropdown = find.byKey(const ValueKey('dropdown'));
    expect(dropdown,findsOneWidget);

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text("Breakfast").last;
    expect(dropdownItem, findsOneWidget);

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    //Le doy al botón de buscar
    final button = find.text("Search");
    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    final scrollableView = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );
    expect(scrollableView, findsOneWidget);


    final previousButton = find.text("Previous");
    final nextButton = find.text("Next");
    await tester.scrollUntilVisible(
      nextButton,
      500.0,
      scrollable: scrollableView,);
    expect(nextButton,findsOneWidget);
    expect(previousButton, findsNothing);

    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    final scrollableView2 = find.descendant(
      of: find.byType(ListView),
      matching:find.byType(Scrollable),
    );
    expect(scrollableView2, findsOneWidget);

    await tester.scrollUntilVisible(
      previousButton,
      500.0,
      scrollable: scrollableView2,);
    expect(previousButton,findsOneWidget);
    expect(nextButton,findsNothing);

  });




}



