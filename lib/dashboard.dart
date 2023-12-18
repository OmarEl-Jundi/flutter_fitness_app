import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'nutrition.dart';
import 'workout_log.dart';

int caloriesIntake = 0;
int caloriesBurned = 0;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AssetImage backgroundImage;

  int _currentIndex = 0;
  late int caloriesLeft;
  @override
  Widget build(BuildContext context) {
    caloriesLeft = caloriesIntake - caloriesBurned;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('images/dashboard.jpg'),
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.075),
                  Container(
                    width: screenWidth * 0.4,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 136, 0),
                    ),
                    child: const Text(
                      'Steps Taken: 10,000 Steps',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Container(
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 136, 0),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Calories Burned: \n$caloriesBurned Kcal',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.075),
                  Container(
                    width: screenWidth * 0.4,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 136, 0),
                    ),
                    child: Text(
                      'Calories Intake: \n$caloriesIntake Kcal',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Container(
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 136, 0),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Calories left to burn: \n$caloriesLeft Kcal',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Color.fromARGB(255, 255, 136, 0),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutLog()),
              );
              _currentIndex = 0;
            }
            if (_currentIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Nutrition()),
              );
              _currentIndex = 0;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor: Color.fromARGB(255, 255, 136, 0),
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
