import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_app/pages/start.dart';

void main() =>
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 136, 71, 242),
          body: Column(
            children: [
              logo(context, width),
              Center(
                child: Column(
                  children: [
                    imageWelcome(context, height),
                    titleWelcome(context, height),
                    subtitleWelcome(context, height),
                    buttonStart(context, height, width)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget logo(context, width) {
  return Container(
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.only(top: 60.0, left: 30.0),
    child: SizedBox(
      width: width * 0.25,
      child: Image.asset('assets/images/logo.png'),
    ),
  );
}

Widget imageWelcome(context, height) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: height * 0.1),
      child: SvgPicture.asset(
        'assets/images/phone_call.svg',
        height: height * 0.25,
      ));
}

Widget titleWelcome(context, height) {
  return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        'True Caller k',
        style: TextStyle(
            color: Colors.white,
            fontSize: height * 0.03,
            fontWeight: FontWeight.w600),
      ));
}

Widget subtitleWelcome(context, height) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Text(
      'Identify who is calling you and decide whether to attend them or not. also receive information about the best offers!',
      style: TextStyle(
        color: Colors.white,
        fontSize: height * 0.02,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget buttonStart(context, height, width) {
  return Container(
    width: width * 0.85,
    height: height * 0.06,
    margin: EdgeInsets.only(top: height * 0.15),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.white,
          onPrimary: const Color.fromARGB(255, 136, 71, 242)),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Start(),
            ));
      },
      child: const Text(
        'Get Start',
        style: TextStyle(fontSize: 16.0),
      ),
    ),
  );
}
