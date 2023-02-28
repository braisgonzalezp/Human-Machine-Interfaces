// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'edamam.dart';

import 'app_info_widget.dart';
import 'models.dart';
import 'filter_widget.dart';
import 'search_bar_widget.dart';
import 'no_ingredient_found_widget.dart';
import 'previous_next_buttons_widget.dart';
import 'details_widget.dart';
import 'detail_row_widget.dart';
import 'company_widget.dart';
import 'privacy_widget.dart';

const String apptitle = "The Cooking Pal";
const int breakPoint = 300;

/* ======================================CONSTRUCCIÓN====================================== */

class RecipeApp extends StatelessWidget {
  final String title;

  const RecipeApp({this.title = apptitle, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Color(0xff052030)),
      home: DecisionClass(title: title,),
    );
  }
}

class DecisionClass extends StatelessWidget {
  final String title;
  const DecisionClass({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool phoneOrTablet = (
              constraints.smallest.longestSide > breakPoint &&
                  MediaQuery.of(context).orientation == Orientation.landscape
          );

          if(!phoneOrTablet) {
            return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fondo2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: MyHomePage(title: title, widget: PhoneHomePage())
            );
          } else {
            return MyHomePage(title: title, widget: TabletHomePage());
          }
        }
    );
  }
}


class MyHomePage extends StatelessWidget {
  final String title;
  final String imagesRoute = 'assets/';
  final widget;

  const MyHomePage({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        //AppBar: Barra horizontal con el nombre y widgets como el drawer y settings.
        title: Text(
          title,
          style: TextStyle(fontFamily: 'HarlandRoselyn', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff052030),
        actions: [
          ActionsOfAppBar(),
        ],
      ),
      body: widget,
    );
  }
}


class PhoneHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<TabletModel>().setIsTablet(false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Image.asset('assets/logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: SearchAndFilter(),
          ),
        ],
      ),
    );
  }
}

class TabletHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<TabletModel>().setIsTablet(true);
    MediaQueryData queryData = MediaQuery.of(context);
    bool startSearch = !context.watch<TabletModel>().startSearch;
    var ingredient = context.read<FormModel>().ingredient;
    var mealType = context.read<FormModel>().mealType;

    return Row(
      children: [
        Container(
          width: queryData.size.width * (2 / 5), //La barra de búsqueda
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Image.asset('assets/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: SearchAndFilter(),
              ),
            ],
          ),
        ),
        Expanded(
          child: (startSearch)
              ? Container(
                    decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/fondo7.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Control(ingredient: ingredient, mealType: mealType, function: ListRecipes()),
        ),
      ],
    );
  }
}

class ActionsOfAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      key: const ValueKey('menuButton'),
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Text("Help"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsHelp(),
                )
            );
          }
        }
    );
  }
}

class SearchAndFilter extends StatefulWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const SearchAndFilter({super.key});

  @override
  State<StatefulWidget> createState() => _SearchAndFilter();
}

class _SearchAndFilter extends State<SearchAndFilter> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: SearchAndFilter.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            //SearchBar
            padding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
            ),
            child: SearchBarWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              'Select the type of meal you want:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              left: 30.0,
              right: 30.0,
            ),
            child: FilterWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SearchButton(widget: SearchAndFilter.formKey,),
          ),
        ],
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  final widget;
  const SearchButton({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (SearchAndFilter.formKey.currentState!.validate()) {
          String ingredient = context.read<FormModel>().ingredient;
          String mealType = context.read<FormModel>().mealType;
          context.read<RecipeModel>().clearStack();

          if(context.read<TabletModel>().isTablet){
            context.read<TabletModel>().setStartSearch(true);
          } else {
            context.read<TabletModel>().setStartSearch(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Control(
                    ingredient: ingredient, mealType: mealType, function: SearchPage(),
                  );
                },
              ),
            );
          }
        }
      },
      child: const Text('Search'),
    );

  }
}


class Control extends StatelessWidget {
  final ingredient;
  final mealType;
  final function;

  const Control({super.key, required this.ingredient, required this.mealType, required this.function});

  @override
  Widget build(BuildContext context) {
    var nextBlock = context.watch<RecipeModel>().nextBlock;
    bool isTablet = context.read<TabletModel>().isTablet;
    return FutureBuilder(
        future: search_recipes(ingredient, mealType, nextBlock),
        builder: (BuildContext context, AsyncSnapshot<RecipeBlock?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text('There was an error'),
                  ],
                ),
              ),
            );
          } else {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fondo7.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              );

            } else {
              var data = snapshot.data!;
              if (data.recipes == null) {
                if (isTablet){
                  return NoIngredientFoundWidget();
                } else {
                  return NoIngredientFoundPage();
                }
              } else {
                //Problema aquí
                context.read<RecipeModel>().setRecipeBlockNoNotify(data);
                return function;
              }
            }
          }
        }
    );
  }
}

class NoIngredientFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'NO RESULTS',
          style: TextStyle(fontFamily: 'HarlandRoselyn', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff052030),
      ),
      body: NoIngredientFoundWidget(),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Results',
          style: TextStyle(fontFamily: 'HarlandRoselyn', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff052030),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListRecipes(),
      ),
    );
  }
}

class ListRecipes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var recipeBlock = context.watch<RecipeModel>().recipeBlock;
    return ListView.builder(

      itemCount: recipeBlock.recipes.length + 1,
      itemBuilder: (context, index) {
        var recipe;
        var image;
        if (index == recipeBlock.recipes.length) {
          return Buttons();
        } else {
          recipe = recipeBlock.recipes[index];
          image = recipe.image;
        }
        return Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3),
                  BlendMode.luminosity,
                )
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF101012),
                offset: Offset(-6, 6),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 120,
                child: ListTile(
                    title: Text(
                      '${recipe.label}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      context.read<InfoModel>().restartExpanders();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(recipe: recipe)
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DetailsPage extends StatelessWidget {
  final recipe;
  const DetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          recipe.label,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color(0xff052030),
      ),
      body: DetailsWidget(recipe: recipe,),
    );
  }
}

class DetailsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help",
          style: TextStyle(fontFamily: 'HarlandRoselyn', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff052030),
      ),
      body: Center(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Company(),
                      ));
                },
                child: DetailRow(
                  icon: const Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  ),
                  text: "Company",
                ),
              ),
              GestureDetector(
                onTap: () {
                  const url = 'https://www.edamam.com/terms';
                  Uri uri = Uri.parse(url);
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: DetailRow(
                  icon: const Icon(
                    Icons.auto_stories_rounded,
                    color: Colors.grey,
                  ),
                  text: "GeneralTerms",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppInfo(),
                      ));
                },
                child: DetailRow(
                  icon: const Icon(
                    Icons.api,
                    color: Colors.grey,
                  ),
                  text: "AppInfo",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Privacy(),
                      ));
                },
                child: DetailRow(
                  icon: const Icon(
                    Icons.privacy_tip,
                    color: Colors.grey,
                  ),
                  text: "Privacy",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Company extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color(0xff052030),
      ),
      body: CompanyWidget(),
    );
  }
}

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff052030),
      ),
      body: PrivacyWidget(),
    );
  }
}
