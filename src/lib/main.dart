import 'dart:math';

import 'package:casui/add_workout.dart';
import 'package:casui/detail_workout.dart';
import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData
          .dark(), //https://medium.com/@amazing_gs/complete-flutter-guide-how-to-implement-dark-mode-dynamic-theming-and-theme-switching-ddabaef48d5a
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white12),
        useMaterial3: true,
      ),
      home: const HomePageWidget(title: ''),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePageWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePageWidget> {
  final List<Workout> _workoutList = [
    Workout.withId(123123, 'Arms n´back inhouse', DateTime(2004),
        'Braços, sem muito equipamento.', 3),
    Workout.withId(
        121212, 'Park arms', DateTime(2004), 'Braços, em um parque.', 3),
    Workout.withId(232323, 'Ultimate Leg Crusher', DateTime(2004),
        'Um treino desenhado ao redor do pistol squat', 3)
  ];

  Future<void> _navigateAndDisplayForm(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddWorkout()));

    if (!context.mounted) return;

    setState(() {
      int randomNumberLimit = 100000;
      var generatedId = Random().nextInt(randomNumberLimit);
      while (!idIsValid(generatedId)) {
        generatedId = Random().nextInt(randomNumberLimit);
      }

      result.id = generatedId;
      _workoutList.add(result);
    });
  }

  bool idIsValid(int id) {
    bool hasSame = false;

    for (Workout w in _workoutList) {
      if (w.id == id) hasSame == true;
    }

    return !hasSame;
  }

  void _deleteWorkout(int id) {
    setState(() {
      _workoutList.removeWhere((w) => w.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.surface,
        // Here we take the value from the HomePageWidget object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'My circuits',
              style: TextStyle(fontSize: 20),
            ),
            //WorkoutElement(),
            makeList(_workoutList, context, _deleteWorkout)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        key: const Key('opa amorrr'),
        onPressed: () => {_navigateAndDisplayForm(context)},
        tooltip: 'Increment',
        label: const Text('New'),
        icon: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column makeList(
      List<Workout> list, BuildContext context, Function deleteCallback) {
    List<Widget> wl = [];
    for (final w in list) {
      wl.add(WorkoutWidget(w, context, deleteCallback));
    }

    return Column(
      children: wl,
    );
  }
}

class WorkoutElement extends StatelessWidget {
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => {},
      key: const Key('Ayyy amo'),
      label: const Text('Eu sou um treino'),
      backgroundColor: Colors.teal[600],
    );
  }
}

Widget WorkoutWidget(
    Workout workout, BuildContext context, Function deleteCallback) {
  Future<void> _navigateAndManage(BuildContext context, Workout workout) async {
    final shit = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailWorkout(workout: workout)));

    if (!context.mounted) return;
  }

  return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () async {
          final selectedAction = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailWorkout(workout: workout)));

          String output = selectedAction.toString();

          List<String> outputSplitted = output.split(" ");
          String action = outputSplitted[0];
          int workoutId = int.parse(outputSplitted[1]);

          if (action == "delete") {
            deleteCallback(workoutId);
          }
        },
        leading: const FlutterLogo(size: 56.0),
        title: Text(workout.title),
        subtitle: Text(workout.description),
      ));
}
