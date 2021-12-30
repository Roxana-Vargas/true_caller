import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

void incomingCall(String number) {
  final uid = uuid.v4();
  const avatar =
      'https://scontent.fhel6-1.fna.fbcdn.net/v/t1.0-9/62009611_2487704877929752_6506356917743386624_n.jpg?_nc_cat=102&_nc_sid=09cbfe&_nc_ohc=cIgJjOYlVj0AX_J7pnl&_nc_ht=scontent.fhel6-1.fna&oh=ef2b213b74bd6999cd74e3d5de235cf4&oe=5F6E3331';
  const type = HandleType.generic;
  const handle = 'Incomin call example';
  const isVideo = true;
  FlutterIncomingCall.displayIncomingCall(
      uid, number, avatar, handle, type, isVideo);
}

void endAllCalls() {
  FlutterIncomingCall.endAllCalls();
}

void callConfiguration() {
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
