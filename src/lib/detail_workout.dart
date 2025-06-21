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
                  onSelected: (WorkoutOptions o) {
                    switch (o) {
                      case WorkoutOptions.delete:
                        print("Delte!");
                        Navigator.pop(context, "delete ${workout.title}");
                        break;

                      case WorkoutOptions.share:
                        print("share!");
                        break;

                      default:
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<WorkoutOptions>>[
                        const PopupMenuItem<WorkoutOptions>(
                          child: Text("Edit"),
                          value: WorkoutOptions.edit,
                        ),
                        const PopupMenuItem<WorkoutOptions>(
                          child: Text("Delete"),
                          value: WorkoutOptions.delete,
                        ),
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
        onPressed: () {
          Navigator.pop(context);
        },
        label: const Text("Start"),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
