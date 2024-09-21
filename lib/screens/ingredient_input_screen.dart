import 'package:flutter/material.dart';

class IngredientInputScreen extends StatefulWidget {
  @override
  _IngredientInputScreenState createState() => _IngredientInputScreenState();
}

class _IngredientInputScreenState extends State<IngredientInputScreen> {
  final List<String> _ingredients = [];
  final TextEditingController _controller = TextEditingController();

  void _addIngredient() {
    if (_controller.text.isNotEmpty && !_ingredients.contains(_controller.text.toLowerCase())) {
      setState(() {
        _ingredients.add(_controller.text.toLowerCase());
        _controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingredient already added or input is empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Ingredients"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add your ingredients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingredient',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.food_bank),
              ),
              onChanged: (text) {
                _controller.text = text.trim(); // Trim spaces
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _addIngredient,
              icon: Image.asset(
                'assets/images/icons/add_icon.png',
                width: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.add); // Fallback to default icon
                },
              ),
              label: Text('Add Ingredient'),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _ingredients.isNotEmpty
                  ? ListView.builder(
                      itemCount: _ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          shadowColor: Colors.grey,
                          child: ListTile(
                            leading: Icon(Icons.kitchen),
                            title: Text(
                              _ingredients[index],
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _ingredients.removeAt(index); // Remove ingredient
                                });
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text("No ingredients added yet")),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ingredients.isNotEmpty
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/recipeList',
                        arguments: _ingredients,
                      );
                    }
                  : null, // Disable button if no ingredients
              child: Text('Find Recipes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
