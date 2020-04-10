import 'package:http/http.dart' as http;

class JsonAdapter {
  Future<String> fetchJson() async {
    final response =
        await http.Client().get('https://jsonbox.io/box_2986699eb9002888887e');
    // Use the compute function to run parsePhotos in a separate isolate.
    return response.body;
  }
}
