class InfomontImage {
  var id;
  var image;

  InfomontImage(this.id, this.image);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfomontImage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
