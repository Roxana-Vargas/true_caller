import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_app/utils/incoming_call.dart';
import 'package:my_app/utils/alerts.dart';

import 'package:my_app/models/callcenter_agent.dart';

import '../services/rest_api_service.dart';

class CallSimulator extends StatefulWidget {
  final String numberPhone;

  const CallSimulator(this.numberPhone, {Key? key}) : super(key: key);

  @override
  _CallSimulatorState createState() => _CallSimulatorState();
}

class _CallSimulatorState extends State<CallSimulator> {
  late Future<CallCenterAgent> callCenterAgent;

  @override
  void initState() {
    super.initState();
    callCenterAgent = fetchCallCenterAgent(widget.numberPhone);
    callConfiguration();
  }

  @override
  void dispose() {
    endAllCalls();
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
                      subtitle(context, callCenterAgent),
                      avatar(context, 0.03, 0.09),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                                tag: 'btnCall',
                                colorButton:
                                    const Color.fromARGB(255, 71, 184, 76),
                                callAction: () {
                                  incomingCall(widget.numberPhone);
                                  alertCallCenterAgent(
                                      context,
                                      callCenterAgent,
                                      widget.numberPhone,
                                      avatar(context, 0.0, 0.07));
                                },
                                iconPhone: const Icon(Icons.call)),
                            Button(
                                tag: 'btnWithDelay',
                                colorButton:
                                    const Color.fromARGB(255, 248, 234, 34),
                                callAction: () {
                                  Future.delayed(const Duration(seconds: 5),
                                      () {
                                    incomingCall(widget.numberPhone);
                                  });
                                },
                                iconPhone: const Icon(Icons.add_ic_call)),
                            Button(
                              tag: 'btnEndCall',
                              colorButton:
                                  const Color.fromARGB(255, 204, 53, 53),
                              callAction: () {
                                endAllCalls();
                                alertProductOffer(context, callCenterAgent);
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
                  child: Image.asset('assets/images/logo.png'),
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
      'assets/images/image_call_simulator.svg',
    ),
  ));
}

Widget title(context) {
  return (Text(
    'Call Simulator',
    style: TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.025,
      fontWeight: FontWeight.w500,
    ),
  ));
}

Widget subtitle(context, modelCallCenterAgent) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.05),
    child: FutureBuilder<CallCenterAgent>(
        future: modelCallCenterAgent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              'The person who call you is ${snapshot.data!.name}',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }),
  );
}

Widget avatar(context, padding, heightAvatar) {
  return (Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height * padding),
    child: CircleAvatar(
      backgroundImage: const NetworkImage(
        'https://www.tu-voz.com/wp-content/uploads/2019/07/callcenter-telemarketing.jpg',
      ),
      radius: MediaQuery.of(context).size.height * heightAvatar,
    ),
  ));
}

class Button extends StatelessWidget {
  final VoidCallback callAction; // Notice the variable type
  final Color colorButton;
  final Icon iconPhone;
  final String tag;

  const Button({
    Key? key,
    required this.callAction,
    required this.colorButton,
    required this.iconPhone,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tag,
      child: iconPhone,
      elevation: 15.0,
      backgroundColor: colorButton,
      onPressed: callAction,
    );
  }
}
