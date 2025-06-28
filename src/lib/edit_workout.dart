import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';

class EditWorkout extends StatelessWidget {
  const EditWorkout({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: [const Text("Edit workout"), WorkoutForm(workout: workout)],
      ),
    );
  }
}

class WorkoutForm extends StatefulWidget {
  final Workout workout;

  const WorkoutForm({super.key, required this.workout});

  @override
  State<StatefulWidget> createState() => WorkoutFormState();
}

class WorkoutFormState extends State<WorkoutForm> {
  Workout get _currentWorkout => widget.workout;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _circuitsController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Se o formulário for válido, podemos acessar os valores dos campos
      String title = _titleController.text;
      String description = _descriptionController.text;
      String circuits = _circuitsController.text;

      var circuit =
          Workout(title, DateTime.now(), description, int.parse(circuits));

      Navigator.pop(context, circuit);
    }
  }

  @override
  void initState() {
    super.initState();

    _titleController.text = _currentWorkout.title;
    _circuitsController.text = _currentWorkout.circuits.toString();
    _descriptionController.text = _currentWorkout.description;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _circuitsController,
                  decoration: const InputDecoration(
                    hintText: 'Circuit reps',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
