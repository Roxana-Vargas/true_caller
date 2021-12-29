import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:my_app/models/callcenter_agent.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

/* Get data of API */
/*
Future<CallCenterAgent> fetchCallCenterAgent() async {
  final response = await http.get(Uri.parse(
      'https://us-central1-seleccion-qa.cloudfunctions.net/getNumberphone?phone=51918604749'));
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return CallCenterAgent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed');
  }
}
*/
void main() => runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, home: CallSimulator()));

class CallSimulator extends StatefulWidget {
  const CallSimulator({Key? key}) : super(key: key);

  @override
  _CallSimulatorState createState() => _CallSimulatorState();
}

class _CallSimulatorState extends State<CallSimulator> {
  var uuid = const Uuid();

  void _incomingCall(String number) {
    final uid = uuid.v4();
    const avatar =
        'https://scontent.fhel6-1.fna.fbcdn.net/v/t1.0-9/62009611_2487704877929752_6506356917743386624_n.jpg?_nc_cat=102&_nc_sid=09cbfe&_nc_ohc=cIgJjOYlVj0AX_J7pnl&_nc_ht=scontent.fhel6-1.fna&oh=ef2b213b74bd6999cd74e3d5de235cf4&oe=5F6E3331';
    const type = HandleType.generic;
    const handle = 'Incomin call example';
    const isVideo = true;
    FlutterIncomingCall.displayIncomingCall(
        uid, number, avatar, handle, type, isVideo);
  }

  void _endAllCalls() {
    FlutterIncomingCall.endAllCalls();
  }

  @override
  void initState() {
    super.initState();
    /*fetchCallCenterAgent();*/
    /*callCenterAgent = fetchCallCenterAgent();*/
    FlutterIncomingCall.configure(
      appName: 'example_incoming_call',
      duration: 30000,
      android: ConfigAndroid(
        vibration: true,
        ringtonePath: 'default',
        channelId: 'calls',
        channelName: 'Calls channel name',
        channelDescription: 'Calls channel description',
      ),
    );
  }

  @override
  void dispose() {
    _endAllCalls();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 136, 71, 242),
          body: Stack(
            children: [
              Container(),
              imageCallSimulator(context),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.43,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      title(context),
                      subtitle(context),
                      avatar(context),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                                colorButton:
                                    const Color.fromARGB(255, 71, 184, 76),
                                callAction: () {
                                  _incomingCall('51920234549');
                                },
                                iconPhone: const Icon(Icons.call)),
                            Button(
                                colorButton:
                                    const Color.fromARGB(255, 248, 234, 34),
                                callAction: () {
                                  Future.delayed(const Duration(seconds: 5),
                                      () {
                                    _incomingCall('51918604749');
                                  });
                                },
                                iconPhone: const Icon(Icons.add_ic_call)),
                            Button(
                              colorButton:
                                  const Color.fromARGB(255, 204, 53, 53),
                              callAction: () {
                                _endAllCalls();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Name'),
                                        content: const Text('Offer'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                debugPrint('Yes');
                                              },
                                              child: const Text('Yes')),
                                          TextButton(
                                              onPressed: () {
                                                debugPrint('No');
                                              },
                                              child: const Text('No')),
                                        ],
                                      );
                                    });
                              },
                              iconPhone: const Icon(Icons.call_end),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  width: 130.0,
                  child: Image.network(
                      'https://www.grupokonecta.com/wp-content/uploads/2016/06/logo.png'),
                ),
              )
            ],
          ),
        ));
  }
}

Widget imageCallSimulator(context) {
  return (Container(
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05),
    height: MediaQuery.of(context).size.height * 0.45,
    width: MediaQuery.of(context).size.width,
    child: SvgPicture.asset(
      'images/image_call_simulator.svg',
    ),
  ));
}

Widget title(context) {
  return (Text(
    'Call Simulator',
    style: TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.03,
      fontWeight: FontWeight.w500,
    ),
  ));
}

Widget subtitle(context) {
  return Container(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
    child: (Text(
      'The person who will call you is Yudith',
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.02,
        fontWeight: FontWeight.w300,
      ),
    )),
  );
}

Widget avatar(context) {
  return (Padding(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
    child: CircleAvatar(
      backgroundImage: const NetworkImage(
        'https://www.tu-voz.com/wp-content/uploads/2019/07/callcenter-telemarketing.jpg',
      ),
      radius: MediaQuery.of(context).size.height * 0.09,
    ),
  ));
}

class Button extends StatelessWidget {
  final VoidCallback callAction; // Notice the variable type
  final Color colorButton;
  final Icon iconPhone;

  const Button({
    Key? key,
    required this.callAction,
    required this.colorButton,
    required this.iconPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'btn1',
      child: iconPhone,
      elevation: 15.0,
      backgroundColor: colorButton,
      onPressed: callAction,
    );
  }
}
/*
class Alert extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  const Alert(
      {Key? key,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 100.0,
            bottom: 16.0,
            right: 16.0,
            left: 16.0,
          ),
          margin: const EdgeInsets.only(top: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
          ),
        )
      ],
    );
  }
}*/
