class PortionDetail {
  final portionName;
  final startPointName;
  final destinationPointName;
  final duration;
  final mark;
  final markState;
  final description;
  final cacheTrekId;

  PortionDetail(
      {this.portionName,
      this.startPointName,
      this.destinationPointName,
      this.duration,
      this.mark,
      this.markState,
      this.description,
      this.cacheTrekId});

  factory PortionDetail.fromDatabase(Map<String, dynamic> entry) {
    return PortionDetail(
        portionName: entry['PortionName'] as String,
        startPointName: entry['StartPointName'] as String,
        destinationPointName: entry['DestinationPointName'] as String,
        duration: entry['Duration'] as int, // TODO: convert to int
        mark: entry['Mark'] as String,
        markState: entry['MarkState'] as String,
        description: entry['Description'] as String,
        cacheTrekId: entry['CacheTrekId'] as int);
  }
}