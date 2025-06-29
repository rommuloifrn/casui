import 'package:casui/models/workout.dart';

class WorkoutService {
  List<Workout> list = [
    Workout('Arms n´back inhouse', DateTime(2004),
        'Braços, sem muito equipamento.', 3),
    Workout('Park arms', DateTime(2004), 'Braços, em um parque.', 3),
    Workout('Ultimate Leg Crusher', DateTime(2004),
        'Um treino desenhado ao redor do pistol squat', 3)
  ];
  List<Workout> findAll() {
    return list;
  }

  Workout create(Workout workout) {
    list.add(workout);
    return workout;
  }

  void delete(String title) {
    list.removeWhere((w) => w.title == title);
  }
}
