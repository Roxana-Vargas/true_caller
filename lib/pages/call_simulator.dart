import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:my_app/models/callcenter_agent.dart';
import 'package:uuid/uuid.dart';

import '../services/rest_api_service.dart';

class CallSimulator extends StatefulWidget {
  final String numberPhone;

  const CallSimulator(this.numberPhone, {Key? key}) : super(key: key);

  @override
  _CallSimulatorState createState() => _CallSimulatorState();
}

class _CallSimulatorState extends State<CallSimulator> {
  late Future<CallCenterAgent> callCenterAgent;

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
    callCenterAgent = fetchCallCenterAgent(widget.numberPhone);
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
                                  _incomingCall(widget.numberPhone);
                                  alertCallCenterAgent(context, callCenterAgent,
                                      widget.numberPhone);
                                },
                                iconPhone: const Icon(Icons.call)),
                            Button(
                                tag: 'btnWithDelay',
                                colorButton:
                                    const Color.fromARGB(255, 248, 234, 34),
                                callAction: () {
                                  Future.delayed(const Duration(seconds: 5),
                                      () {
                                    _incomingCall(widget.numberPhone);
                                  });
                                },
                                iconPhone: const Icon(Icons.add_ic_call)),
                            Button(
                              tag: 'btnEndCall',
                              colorButton:
                                  const Color.fromARGB(255, 204, 53, 53),
                              callAction: () {
                                _endAllCalls();
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

void alertCallCenterAgent(context, model, phone) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 211, 193, 240), Colors.white],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.75, 0.25],
                  tileMode: TileMode.clamp,
                )),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Column(
                  children: [
                    FutureBuilder<CallCenterAgent>(
                        future: model,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                child: Row(
                                  children: [
                                    avatar(context, 0.0, 0.07),
                                    Container(
                                      margin: const EdgeInsets.only(left: 30.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data!.name,
                                            style: TextStyle(
                                                fontFamily: 'RobotoMono',
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03),
                                          ),
                                          Center(
                                            child: Text(
                                              snapshot.data!.enterprise,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.025),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text('$phone - Mobile',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02))
                                ],
                              )
                            ]);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                  ],
                ))
          ],
        );
      });
}

void alertProductOffer(context, model) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: FutureBuilder<CallCenterAgent>(
            future: model,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Column(
                    children: [
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(snapshot.data!.offer)
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
          ],
        );
      });
}
