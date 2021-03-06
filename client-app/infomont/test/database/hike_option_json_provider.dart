import 'dart:convert';
import 'package:app/db/hike_option_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'json_adapter.dart';

class HikeOptionJsonProvider implements HikeOptionProvider {
  final JsonAdapter jsonAdapter;

  const HikeOptionJsonProvider(this.jsonAdapter);

  Future<List<HikeOption>> fetchHikeOptions(
      int departurePointId, int destinationPointId) async {
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
