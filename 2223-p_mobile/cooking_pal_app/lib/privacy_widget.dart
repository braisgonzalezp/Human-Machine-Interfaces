
import 'package:flutter/material.dart';

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(40.0),
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
            'Privacy',
            style: TextStyle(
                fontFamily: 'HarlandRoselyn',
                fontSize: 70,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.asset('assets/logo.png'),
          const Text(
            '\n© 2020-2022 The Cooking Pal\n\n',
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Text(
            'The Information We Collect\n',
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Information You Give Us',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nInformation You Give Us. We collect certain personal information via the Services when an End User or Enterprise User provides it to us, such as recipe data.',
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nInformation Automatically Collected',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nWhen an End User or Enterprise User engages with the Services (e.g., visiting an Enterprise Site with the Services enabled), we collect certain non-personally identifiable information for analytics purposes and for online ad targeting as described below. \n\nWe automatically log information about you and your device. We collect non-personally identifiable information via the Services. For example, when you visit a Enterprise Site that contains the Services, our server logs collect (among other things) your Internet Protocol address, device type, browser type, browser language, the date and time you visited that web page. We may also use this information in the aggregate to help us build commercially viable data segments and data sets to improve the Services.\n\nWe also may set Cookies where the Services are enabled.',
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nInformation We Get from Other Sources',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const Text(
            '\nWe may get information about you from other sources. We may add this to information we get from the Services. Also, in addition to the information we collect online, there is information that we will collect offline in certain instances. Such information can be collected at The Cooking Pal events, The Cooking Pal sponsored events, or The Cooking Pal solicitations.',
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
