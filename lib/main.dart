import 'package:flutter/material.dart';
import 'screens/ingredient_input_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'models/recipe.dart';


void main() {
  runApp(OkraKaleRecipeApp());
}

class OkraKaleRecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okra Kale Recipe App',
      theme: ThemeData(primarySwatch: Colors.green),
      textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: TextStyle(fontSize: 16, color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded button corners
          ),
        ),
      ),
       // Define your screen routes here
      initialRoute: '/ingredients',
      routes: {
        '/ingredients': (context) => IngredientInputScreen(),
        '/recipeList': (context) => RecipeListScreen(), // This will need arguments to pass user ingredients
        '/recipeDetail': (context) => RecipeDetailScreen(), // This will need to pass a recipe object 
      },
    );
  }
}
