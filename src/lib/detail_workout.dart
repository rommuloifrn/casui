import 'package:casui/edit_workout.dart';
import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum WorkoutOptions { delete, edit, share }

class DetailWorkout extends StatefulWidget {
  const DetailWorkout({super.key, required this.workout});

  final Workout workout;

  @override
  State<StatefulWidget> createState() => _DetailWorkoutState();
}

class _DetailWorkoutState extends State<DetailWorkout> {
  Workout get workout => widget.workout;

  Future<void> _navigateToEdition(BuildContext context) async {
    final circuit = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditWorkout(workout: workout)));

    if (!context.mounted) return;

    setState(() {
      workout.title = circuit.title;
      workout.description = circuit.description;
      workout.circuits = circuit.circuits;
    });

    Navigator.pop(context, ['edit', workout]);
  }

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
                        Navigator.pop(context, ["delete", workout]);
                        break;

                      case WorkoutOptions.edit:
                        _navigateToEdition(context);
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
            workout.description,
          ),
          Text(
              "Created in ${DateFormat("MMMM, d yyyy").format(workout.created)}"),
          const Text("Last exec: 20/04 (8 days ago)")
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
