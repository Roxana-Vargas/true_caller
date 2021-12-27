import 'package:pigeon/pigeon.dart';

class SearchRequest {
  String query = '';
}

class SearchReply {
  String result = '';
}

@HostApi()
class Api {
  Future search(SearchRequest request);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
