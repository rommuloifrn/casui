import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';

enum WorkoutOptions { delete, edit, share }

class DetailWorkout extends StatelessWidget {
  const DetailWorkout({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("casui"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(workout.title),
          Text("Circuits: ${workout.circuits}"),
          Text("Created in ${workout.created}"),
          TextButton(
            child: Text(
              "Deletar",
            ),
            onPressed: () {},
          ),
          PopupMenuButton<WorkoutOptions>(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<WorkoutOptions>>[
                    const PopupMenuItem<WorkoutOptions>(child: Text("Edit")),
                    const PopupMenuItem<WorkoutOptions>(child: Text("Delete")),
                    const PopupMenuItem<WorkoutOptions>(child: Text("Share")),
                  ])
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Start"),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
