import 'dart:convert';

import 'hike_option.dart';
import 'json_adapter.dart';

class HikeOptionJsonProvider {
  final JsonAdapter jsonAdapter;

  const HikeOptionJsonProvider(this.jsonAdapter);

  Future<List<HikeOption>> fetchHikeOptions() async {
    final json = await jsonAdapter.fetchJson();
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseHikeOptions(json);
  }

  Future<List<HikeOption>> parseHikeOptions(String responseBody) async {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HikeOption>((element) => HikeOption.fromJson(element))
        .toList();
  }
}
