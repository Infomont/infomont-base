class Point {
  final int id;
  final String name;

  Point(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Point {id: $id, name: $name}';
  }
}
