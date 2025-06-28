class Workout {
  late int id;
  String title;
  String description;
  DateTime created;
  int circuits;

  Workout(this.title, this.created, this.description, this.circuits);

  Workout.withId(
      this.id, this.title, this.created, this.description, this.circuits);
}
