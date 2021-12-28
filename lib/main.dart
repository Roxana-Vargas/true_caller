import 'package:flutter/material.dart';
import 'package:my_app/pages/call_simulator.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Home'),
              TextButton(
                  onPressed: () {
                    debugPrint('start');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CallSimulator(),
                        ));
                  },
                  child: const Text('Start')),
            ],
          ),
        ),
      ),
    );
  }
}
