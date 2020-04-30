class Point {
  int id;
  String name;
  String description;

  Point({this.id, this.name, this.description});

  factory Point.fromJson(Map<String, dynamic> data) => new Point(id: data["id"], name:data["name"], description: data["description"],);
  factory Point.fromDatabase(Map<String, dynamic> data) => new Point(id: data["ID"], name:data["Name"], description: data["Description"],);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };

  @override
  String toString() {
    return 'Point {id: $id, name: $name}';
  }
}