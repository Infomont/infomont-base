
import 'package:app/db/abstract_db_provider.dart';
import 'package:app/entities/portion_detail.dart';


class PortionDetailDbProvider{
  final IDBProvider dbProvider;

  PortionDetailDbProvider(this.dbProvider);

  Future<List<PortionDetail>> getPortionDetails(int departurePointId, int destinationPointId) async {
    final db = await dbProvider.database;

    final queryString = '''
    Select StartPoint.Name || ' - ' || DestinationPoint.Name as PortionName,
    StartPoint.Name as StartPointName, DestinationPoint.Name as DestinationPointName,
    Portion.Duration, MarkImages.MarkCode as MarkCode, MarkImages.Image as MarkImage, MarkState.Description as MarkState,
    Portion.Description, CTP.CacheTrekID as CacheTrekId, PortionInt.Text as EnglishDescription, PortionInt.IdLang
    from Cache_Trek_Portions CTP
    inner join Portion
    on Portion.ID = CTP.IDPortion
    Inner Join Point as StartPoint
    on Portion.StartPointID = StartPoint.ID
    Inner Join Point as DestinationPoint
    on Portion.DestinationPointID = DestinationPoint.ID
    Inner Join MarkType
    On Portion.MarkType = MarkType.ID
    Inner Join MarkImages
    On Portion.MarkType = MarkImages.ID
    Inner Join MarkState
    On Portion.MarkState = MarkState.ID
    Left Outer Join PortionInt
    On PortionInt.IDField = Portion.ID
    And PortionInt.IdLang = (Select Id from Language where Language.LanguageParticle == "en-GB")
    Where CTP.CacheTrekID in (
    Select CT.ID as CacheTrekID from Cache_Trek CT
    inner join point as DeparturePoint
    on CT.IDDepPoint = DeparturePoint.ID
    inner join point as DestinationPoint
    on CT.IDDestPoint = DestinationPoint.ID
    where CT.IDDepPoint = $departurePointId
    And CT.IDDestPoint = $destinationPointId
    limit 10
    )
    Order by CTP.PortionOrder''';

    var result = await db.rawQuery(queryString);

    if (result.isEmpty) return [];

    return result.isNotEmpty
        ? result.map((o) => PortionDetail.fromDatabase(o)).toList()
        : [];
  }
}