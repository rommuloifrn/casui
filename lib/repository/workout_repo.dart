import 'package:casui/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openMyDatabase() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for database operations

  return openDatabase(
    join(await getDatabasesPath(), 'user_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE workouts(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, created TEXT, circuits INTEGER)',
      );
    },
    version: 1,
  );
}

Future<void> insertWorkout(Workout wk) async {
  // Get a reference to the database.
  final db = await openMyDatabase();

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'workouts',
    wk.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateWorkout(Workout workout) async {
  // Get a reference to the database.
  final db = await openMyDatabase();

  // Update the given Dog.
  await db.update(
    'workouts',
    workout.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [workout.id],
  );
}

Future<void> deleteWorkout(int id) async {
  // Get a reference to the database.
  final db = await openMyDatabase();

  // Remove the Dog from the database.
  await db.delete(
    'workouts',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

Future<List<Workout>> retrieveWorkouts() async {
  // Get a reference to the database.
  final db = await openMyDatabase();

  // Query the table for all the dogs.
  final List<Map<String, Object?>> workoutMaps = await db.query('workouts');


  // Convert the list of each dog's fields into a list of `Dog` objects.
  var result = [
    for (final {
          'id': id as int,
          'title': title as String,
          'description': description as String,
          'created': created as String,
          'circuits': circuits as int
        } in workoutMaps)
      Workout.withId(id, title, DateTime.parse(created), description, circuits),
  ];

  return result;
}
