class Workout {
  late int id;
  String title;
  String description;
  DateTime created;
  int circuits;

  Workout(this.title, this.created, this.description, this.circuits);

  Workout.withId(
      this.id, this.title, this.created, this.description, this.circuits);

  Map<String, Object?> toMap() {
    return {
      'title': title, 
      'description': description,
      'circuits': circuits,
      'created': created.toIso8601String()
      };
  }

  @override
  String toString() {
    return 'Workout{id: $id, title: $title}';
  }
}
