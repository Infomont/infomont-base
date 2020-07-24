import 'package:flutter_test/flutter_test.dart';
import 'package:app/entities/hike_option.dart';
import 'database/hike_option_json_provider.dart';
import 'json_adapter_stub.dart';

// language=JSON
const tmpJson = '''
[
{
"optionName": "1-Breaza - Peaks Brezei - Chalet Urlea",
"duration": "3h 30min",
"shortDescription": " From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called \\\"Pe Livadia\\\" (\\\"At the orchard\\\"), where there is a orchard nursery. Here there is a pole with indicating plates. ",
"marks": "Red Triangle",
"marksQuality": "★★★★☆",
"difficulty": "★☆☆☆☆"
},
{
"optionName": "2-Breaza - Peaks Brezei - Chalet Urlea",
"duration": "3h 30min",
"shortDescription": " From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called \\\"Pe Livadia\\\" (\\\"At the orchard\\\"), where there is a orchard nursery. Here there is a pole with indicating plates. ",
"marks": "Red Triangle",
"marksQuality": "★★★★☆",
"difficulty": "★☆☆☆☆"
},
{
"optionName": "3-Breaza - Peaks Brezei - Chalet Urlea",
"duration": "3h 30min",
"shortDescription": " From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called \\\"Pe Livadia\\\" (\\\"At the orchard\\\"), where there is a orchard nursery. Here there is a pole with indicating plates. ",
"marks": "Red Triangle",
"marksQuality": "★★★★☆",
"difficulty": "★☆☆☆☆"
}
]
''';

final route1Text = '1-Breaza - Peaks Brezei - Chalet Urlea';
final route2Text = '2-Breaza - Peaks Brezei - Chalet Urlea';
final route3Text = '3-Breaza - Peaks Brezei - Chalet Urlea';

void main() {
  test('Processes correctly the hike options from the data provider', () async {
    // TODO, check if needs to be async
    var jsonAdapterStub = JsonAdapterStub();
    jsonAdapterStub.json = tmpJson;
    final provider = HikeOptionJsonProvider(jsonAdapterStub);
    var actual = await provider.fetchHikeOptions(4711, 0815); // arbitrary ids

    var result = List<HikeOption>();
    result.add(HikeOption(optionName: route1Text));
    result.add(HikeOption(optionName: route2Text));
    result.add(HikeOption(optionName: route3Text));

    expect(result,
        actual); // TODO: only assert optionNames, instead of relying on the current implementation of HikeOption.==
  });
}
