import 'dart:convert';

import 'package:app/hike_option.dart';
import 'package:http/http.dart' as http;

class HikeOptionProvider {
  const HikeOptionProvider();

  Future<List<HikeOption>> fetchHikeOptions() async {
    final response =
        await http.Client().get('https://jsonbox.io/box_2986699eb9002888887e');
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseHikeOptions(response.body);
  }

  List<HikeOption> parseHikeOptions(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HikeOption>((json) => HikeOption.fromJson(json)).toList();
  }
}
