class Movement {
  String id;
  String title;
  String description;
  bool isometric;
  
  Movement(this.id, this.title, this.description, this.isometric);

  @override
  String toString() {
    return 'Movement{id: $id, name: $title, isometric: $isometric}';
  }
}