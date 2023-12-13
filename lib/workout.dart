import 'package:flutter/material.dart';
import 'dashboard.dart';

class Workout extends StatefulWidget {
  final String selectedWorkout;

  const Workout({Key? key, required this.selectedWorkout}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  List<bool> checkedExercises = [];

  @override
  void initState() {
    super.initState();
    List<String> exercises = [];

    if (widget.selectedWorkout == 'Cardio') {
      exercises = cardioExercises;
    } else if (widget.selectedWorkout == 'Weight Lifting') {
      exercises = weightLiftingExercises;
    } else if (widget.selectedWorkout == 'Yoga') {
      exercises = yogaExercises;
    }

    checkedExercises = List<bool>.filled(exercises.length, false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> exercises = [];

    if (widget.selectedWorkout == 'Cardio') {
      exercises = cardioExercises;
    } else if (widget.selectedWorkout == 'Weight Lifting') {
      exercises = weightLiftingExercises;
    } else if (widget.selectedWorkout == 'Yoga') {
      exercises = yogaExercises;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Workout: ${widget.selectedWorkout}'),
          backgroundColor: Colors.cyanAccent,
        ),
        body: Stack(fit: StackFit.expand, children: [
          const Image(
            image: AssetImage('images/workout.jpg'),
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(exercises[index]),
                        trailing: Checkbox(
                          value: checkedExercises[index],
                          onChanged: (bool? value) {
                            setState(() {
                              checkedExercises[index] = value ?? false;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int totalCheckedExercises =
                      checkedExercises.where((element) => element).length;
                  setState(() {
                    caloriesBurned += totalCheckedExercises * 100;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                },
                child: Text('Done Working Out'),
              ),
            ],
          ),
        ]));
  }
}

List<String> cardioExercises = [
  'Running',
  'Cycling',
  'Jumping Rope',
  'Rowing',
  'Swimming',
];

List<String> weightLiftingExercises = [
  'Bench Press',
  'Bicep Curls',
  'Tricep Extensions',
  'Squats',
  'Deadlifts',
];

List<String> yogaExercises = [
  'Downward Dog',
  'Warrior Pose',
  'Tree Pose',
  'Child\'s Pose',
  'Mountain Pose',
];
