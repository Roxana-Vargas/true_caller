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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(),
            imageStart(context),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Color.fromARGB(255, 136, 71, 242),
                ),
                child: Column(
                  children: [
                    titleStart(context),
                    subtitleStart(context),
                    inputForPhoneCode(context),
                    inputForEnterNumber(context),
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

  Widget imageStart(context) {
    return (SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.height,
      child: Image.asset('assets/images/image_start.jpg'),
    ));
  }

  Widget titleStart(context) {
    return (Text(
      'True Caller K',
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ));
  }

  Widget subtitleStart(context) {
    return (Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.035),
      child: Text(
        'Enter the cell phone number with which you want to simulate your call',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.02,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget inputForPhoneCode(context) {
    return (TextField(
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.02,
      ),
      enabled: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Image.asset('assets/images/flag.png'),
          height: MediaQuery.of(context).size.height * 0.02,
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

  Widget inputForEnterNumber(context) {
    TextEditingController _numberPhoneController =
        TextEditingController(text: "");

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.015),
          child: TextField(
            onChanged: (value) {
              if (value.length == 9) {
                setState(() {
                  isButtonActive = true;
                  textPhone = value;
                });
              }
            },
            keyboardType: TextInputType.text,
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
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
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
              debugPrint(_numberPhoneController.text);
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
