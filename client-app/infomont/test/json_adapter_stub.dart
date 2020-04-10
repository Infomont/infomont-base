import 'package:app/json_adapter.dart';

class JsonAdapterStub extends JsonAdapter {
  JsonAdapterStub();

  String _json;

  set json(value) {
    _json = value;
  }

  @override
  Future<String> fetchJson() async {
    return _json;
  }
}
