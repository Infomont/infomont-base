import 'dart:convert';

import 'package:app/hike_option.dart';
import 'package:http/http.dart' as http;

import 'json_adapter.dart';

class HikeOptionProvider {
  final JsonAdapter jsonAdapter;

  const HikeOptionProvider(this.jsonAdapter);

  Future<List<HikeOption>> fetchHikeOptions() async {
    final json =
        await jsonAdapter.fetchJson();
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseHikeOptions(json);
  }

  Future<List<HikeOption>> parseHikeOptions(String responseBody) async {
    //final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    //return parsed.map<HikeOption>((element) => HikeOption.fromJson(element)).toList();

    final route1Text = '1-Breaza - Peaks Brezei - Chalet Urlea';
    final route2Text = '2-Breaza - Peaks Brezei - Chalet Urlea';
    final route3Text = '3-Breaza - Peaks Brezei - Chalet Urlea';

    var result = List<HikeOption>();
    result.add(HikeOption(optionName: route1Text));
    result.add(HikeOption(optionName: route2Text));
    result.add(HikeOption(optionName: route3Text));
    return result;
  }
}
