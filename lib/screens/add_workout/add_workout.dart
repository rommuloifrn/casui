import 'package:casui/models/movement.dart';
import 'package:casui/models/workout.dart';
import 'package:casui/repository/workout_repo.dart';
import 'package:dio/dio.dart';
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
  State<StatefulWidget> createState() => WorkoutFormState();
}

class WorkoutFormState extends State<WorkoutForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _circuitsController = TextEditingController();

  final _movementList = <Movement>[];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Se o formulário for válido, podemos acessar os valores dos campos
      String title = _titleController.text;
      String description = _descriptionController.text;
      String circuits = _circuitsController.text;

      var circuit =
          Workout(title, DateTime.now(), description, int.parse(circuits));

      insertWorkout(circuit);

      print('titulo: $title, desc: $description, n circuits: $circuits');
      // Aqui você faria a lógica de envio dos dados, por exemplo, para uma API.
      retrieveWorkouts();
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
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  Future<List<Movement>> getMovements() async {
    final response = await Dio().get('http://localhost:8080/movement');

    var movesJson = response.data;

    var moves = [
      for (final {
            'id': id as String,
            'title': title as String,
            'description': description as String,
            'isometric': isometric as bool
          } in movesJson)
        Movement(id, title, description, isometric),
    ];

    return moves;
  }

  Future updateMovements() async {
    var moves = await getMovements();

    setState(() {
      _movementList.clear();
      moves.forEach((m) => _movementList.add(m));
    });
  }

  @override
  Widget build(BuildContext context) {
    updateMovements();

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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: movementsToWidgets(_movementList),
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

List<Widget> movementsToWidgets(List<Movement> moves) {
  List<Widget> wds = [];

  moves.forEach((m) => wds.add(Card(
        child: ListTile(
          title: Text(m.title),
          subtitle: Text(m.description),
          leading: const Icon(Icons.sports_gymnastics),
          onTap: ()=>{},
        ),
      )));

  return wds;
}
