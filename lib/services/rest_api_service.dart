import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/callcenter_agent.dart';

Future<CallCenterAgent> fetchCallCenterAgent(numberPhone) async {
  final response = await http.get(Uri.parse(
      'https://us-central1-seleccion-qa.cloudfunctions.net/getNumberphone?phone=51$numberPhone'));
  if (response.statusCode == 200) {
    return CallCenterAgent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed');
  }
}
