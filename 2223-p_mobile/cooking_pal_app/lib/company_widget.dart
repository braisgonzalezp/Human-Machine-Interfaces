
import 'package:flutter/material.dart';
import 'developer_user_widget.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(40),
        children: <Widget>[
          const Text(
            'The team',
            style: TextStyle(
                fontFamily: 'HarlandRoselyn',
                fontSize: 70,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.asset('assets/logo.png'),
          const Text(
            '© 2020-2022 The Cooking Pal',
            style: TextStyle(fontSize: 10, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Text(
            '\nAbout Us',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nWe are about eating better. Our goal is to capture the world\'s food knowledge and distill it to help you make informed choices at the store and in the kitchen\n',
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.left,
          ),

          Column(
            children: const <Widget>[
              DeveloperUserWidget(
                photo: 'assets/Avatar.png',
                name: 'Armando Noya',
                text:
                '"Making knowledge and information ubiquitous really excites me. This is what semantics and internet can do best – decipher information and bring it to everyone’s doorstep."',
              ),
              DeveloperUserWidget(
                photo: 'assets/Avatar2.png',
                name: 'Raúl Fernández',
                text:
                '\n"Our wide-eyed aspiration is to help everyone on Earth eat better. We dream of digital executive chefs, virtual nutritionists and smart stoves."',
              ),
              DeveloperUserWidget(
                photo: 'assets/Avatar3.png',
                name: 'Brais González',
                text:
                '\n\n"Early to bed, early to rise, makes the man healthy, wealthy and wise"',
              ),
            ],
          ),
        ],
      ),
    );
  }
}