import 'package:flutter/material.dart';

const String apptitle = "The Cooking Pal";

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Info',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: const Color(0xff052030),
      ),
      body: Container(
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
              apptitle,
              style: TextStyle(
                  fontFamily: 'HarlandRoselyn',
                  fontSize: 70,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Text(
              '\nVersion 1.0.0 (Beta)',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/logo.png'),
            const Text(
              '\n© 2020-2022 The Cooking Pal',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}