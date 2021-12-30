import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/pages/call_simulator.dart';

void main() => runApp(const Start());

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  String textPhone = '';
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(),
            imageStart(context, height, width),
            Positioned(
              top: height * 0.48,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                padding: EdgeInsets.all(height * 0.03),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Color.fromARGB(255, 136, 71, 242),
                ),
                child: Column(
                  children: [
                    titleStart(context, height),
                    subtitleStart(context, height),
                    inputForPhoneCode(context, height),
                    inputForEnterNumber(context, height, width),
                  ],
                ),
              ),
            ),
            logo(),
          ],
        ),
      ),
    );
  }

  Widget imageStart(context, height, width) {
    return (SizedBox(
      height: height * 0.55,
      width: width,
      child: Image.asset('assets/images/image_start.jpg'),
    ));
  }

  Widget titleStart(context, height) {
    return (Text(
      'True Caller K',
      style: TextStyle(
        fontSize: height * 0.03,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ));
  }

  Widget subtitleStart(context, height) {
    return (Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.035),
      child: Text(
        'Enter the cell phone number with which you want to simulate your call',
        style: TextStyle(
          fontSize: height * 0.02,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget inputForPhoneCode(context, height) {
    return (TextField(
      style: TextStyle(
        fontSize: height * 0.02,
      ),
      enabled: false,
      decoration: InputDecoration(
        suffixIcon: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Image.asset('assets/images/flag.png'),
          height: height * 0.02,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: "Perú +51",
      ),
    ));
  }

  Widget inputForEnterNumber(context, height, width) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height * 0.015),
          child: TextField(
            onChanged: (value) {
              if (value.length == 9) {
                setState(() {
                  isButtonActive = true;
                  textPhone = value;
                });
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Enter the number to simulate the call",
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.025),
          width: width * 0.9,
          height: height * 0.06,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: isButtonActive
                    ? const Color.fromARGB(255, 66, 8, 201)
                    : const Color.fromARGB(255, 216, 207, 216),
                onPrimary: isButtonActive
                    ? const Color.fromARGB(255, 247, 247, 248)
                    : const Color.fromARGB(255, 126, 119, 126)),
            onPressed: () {
              isButtonActive
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallSimulator(textPhone),
                      ))
                  : null;
            },
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }

  Widget logo() {
    return (SafeArea(
        child: Container(
      padding: const EdgeInsets.all(25.0),
      width: 130.0,
      child: SvgPicture.asset(
        'assets/images/logo_grey.svg',
      ),
    )));
  }
}
