import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AddWorkout());
}

class AddWorkout extends StatelessWidget {
  const AddWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("casui"),
      ),
      body: const WorkoutForm(),
    );
    
  }
}

class WorkoutForm extends StatefulWidget {
  const WorkoutForm({super.key});

  @override
  State<StatefulWidget> createState() =>
  WorkoutFormState();
}

class WorkoutFormState extends State<WorkoutForm> {
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

      var circuit = Workout(
        title,
        DateTime.now(),
        description,
        4
      );

      print('titulo: $title, desc: $description, n circuits: $circuits');
      // Aqui você faria a lógica de envio dos dados, por exemplo, para uma API.
      Navigator.pop(context, circuit);
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      final String text = _titleController.text.toLowerCase();
      _titleController.value = _titleController.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(_titleController.text),
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
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}