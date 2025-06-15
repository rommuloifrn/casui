import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum WorkoutOptions { delete, edit, share }

class DetailWorkout extends StatelessWidget {
  const DetailWorkout({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workout.title,
                style: const TextStyle(fontSize: 22),
              ),
              PopupMenuButton<WorkoutOptions>(
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<WorkoutOptions>>[
                        const PopupMenuItem<WorkoutOptions>(
                            child: Text("Edit")),
                        const PopupMenuItem<WorkoutOptions>(
                            child: Text("Delete")),
                        const PopupMenuItem<WorkoutOptions>(
                            child: Text("Share")),
                      ])
            ],
          ),
          Text("${workout.circuits} circuits"),
          Text(
              "Created in ${DateFormat("MMMM, d yyyy").format(workout.created)}"),
          Text("Last exec: 20/04 (8 days ago)")
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
