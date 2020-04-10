import 'package:app/json_adapter.dart';

class JsonAdapterStub extends JsonAdapter{
  JsonAdapterStub();

  var _json;

  set json(value) {
    _json = value;
  }

  @override
  fetchJson(){
    return _json;
  }


}