import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'workout_log.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  State<Nutrition> createState() => _NutritionState();
}

class FoodItem {
  String name;
  int calories;

  FoodItem({required this.name, required this.calories});
}

class _NutritionState extends State<Nutrition> {
  int _currentIndex = 2;

  TextEditingController _foodNameController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();

  void _calculateCaloriesIntake() {
    int totalCalories = 0;
    for (var foodItem in _foodList) {
      totalCalories += foodItem.calories;
    }
    setState(() {
      caloriesIntake = totalCalories;
    });
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(fit: StackFit.expand, children: [
        const Image(
          image: AssetImage('images/nutrition.jpg'),
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _foodNameController,
                      decoration: const InputDecoration(
                        labelText: 'Food Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Calories',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String foodName = _foodNameController.text.trim();
                        int calories =
                            int.tryParse(_caloriesController.text) ?? 0;

                        if (foodName.isNotEmpty && calories > 0) {
                          _foodList.add(
                              FoodItem(name: foodName, calories: calories));
                          _foodNameController.clear();
                          _caloriesController.clear();
                          _calculateCaloriesIntake(); // Update caloriesIntake
                        }
                      });
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${_foodList[index].name}'),
                    subtitle: Text('Calories: ${_foodList[index].calories}'),
                  );
                },
              ),
            ),
          ],
        ),
      ]),
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
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutLog()),
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

List<FoodItem> _foodList = [];
