import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';

/// Load and combine recipes from multiple JSON files
Future<List<Recipe>> loadAllRecipes() async {
  final jsonFiles = [
    'assets/recipes/desserts.json',
    'assets/recipes/indian.json',
    'assets/recipes/international.json',
    'assets/recipes/italianrecipe.json',
    'assets/recipes/seafoodrecip.json',
    'assets/recipes/smoothies.json'
  ];

  List<Recipe> allRecipes = [];

  // Loop through all recipe JSON files
  for (var file in jsonFiles) {
    try {
      final jsonString = await rootBundle.loadString(file);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Extract recipes based on JSON structure
      if (jsonData.containsKey('recipes')) {
        // Standard recipe structure
        final List<dynamic> recipesJson = jsonData['recipes'];
        allRecipes.addAll(recipesJson.map((recipe) => Recipe.fromJson(recipe)).toList());
      } else if (jsonData.containsKey('smoothies')) {
        // Smoothie recipe structure (nested categories)
        final List<dynamic> spirulinaSmoothies = jsonData['smoothies']['spirulina_smoothies'];
        final List<dynamic> smoothieRecipes = jsonData['smoothies']['smoothie_recipes'];
        allRecipes.addAll(spirulinaSmoothies.map((recipe) => Recipe.fromJson(recipe)).toList());
        allRecipes.addAll(smoothieRecipes.map((recipe) => Recipe.fromJson(recipe)).toList());
      }
    } catch (e) {
      // Log the error and continue loading other files
      print('Error loading or parsing file $file: $e');
      continue;
    }
  }

  return allRecipes;
}

/// Suggest the closest matching recipe based on the most matching ingredients
Recipe? suggestCloseRecipe(List<Recipe> allRecipes, List<String> userIngredients) {
  Recipe? closestMatch;
  int highestMatchCount = 0;

  // Loop through all recipes to find the closest match
  for (var recipe in allRecipes) {
    int matchCount = recipe.ingredients.where((ingredient) {
      return userIngredients.contains(ingredient.item.toLowerCase());
    }).length;

    if (matchCount > highestMatchCount) {
      highestMatchCount = matchCount;
      closestMatch = recipe;
    }
  }

  // Return the recipe with the highest number of matching ingredients
  return closestMatch;
}
