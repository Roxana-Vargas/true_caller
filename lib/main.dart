import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:my_app/models/callcenter_agent.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

/* Fetch api */

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
}*/

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: Scaffold(
      body: Stack(
        children: [
          Container(),
          Container(
            height: 600.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://cdn1.vectorstock.com/i/1000x1000/69/15/call-center-isometric-3d-concept-vector-23576915.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            top: 500.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              padding: const EdgeInsets.all(35.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    'Call Simulator',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://www.tu-voz.com/wp-content/uploads/2019/07/callcenter-telemarketing.jpg',
                      ),
                      radius: 80.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          child: const Icon(Icons.call),
                          elevation: 15.0,
                          backgroundColor: Colors.green,
                          onPressed: () {
                            _incomingCall('51918604749');
                          },
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.add_ic_call),
                          elevation: 15.0,
                          backgroundColor: Colors.amber,
                          onPressed: () {
                            Future.delayed(const Duration(seconds: 5), () {
                              _incomingCall('51918604749');
                            });
                          },
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.call_end),
                          elevation: 15.0,
                          backgroundColor: Colors.red,
                          onPressed: () {
                            _endAllCalls();
                          },
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
