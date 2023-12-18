import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'nutrition.dart';
import 'workout.dart';

class WorkoutLog extends StatefulWidget {
  const WorkoutLog({Key? key}) : super(key: key);

  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  int _currentIndex = 1;
  String _selectedWorkoutType = 'Cardio';

  List<String> _workoutTypes = [
    'Cardio',
    'Weight Lifting',
    'Yoga',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Log'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('images/workout_log.jpg'),
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Select Workout Type:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                DropdownButton<String>(
                  value: _selectedWorkoutType,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.redAccent,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.redAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedWorkoutType = newValue!;
                    });
                  },
                  items: _workoutTypes
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  dropdownColor: Colors.blueAccent,
                  iconEnabledColor: Colors.redAccent,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Workout(selectedWorkout: _selectedWorkoutType),
                      ),
                    );
                  },
                  child: Text('Start $_selectedWorkoutType Workout'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
              _currentIndex = 1;
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Nutrition()),
              );
            }
            if (index != _currentIndex) {
              _currentIndex = index;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout Log',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Nutrition',
            backgroundColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
