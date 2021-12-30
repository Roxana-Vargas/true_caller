import 'package:flutter/material.dart';

import '../models/callcenter_agent.dart';

void alertCallCenterAgent(context, model, phone, avatar) {
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
                                    avatar,
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
