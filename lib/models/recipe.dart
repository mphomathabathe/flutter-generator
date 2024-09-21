import 'ingredient.dart';

class Recipe {
  final String name;
  final List<Ingredient> ingredients;
  final List<String> method;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.method,
  });

  // Parse Recipe from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Validate the 'name' field
    if (json['name'] == null || json['name'].toString().isEmpty) {
      throw ArgumentError('Invalid or missing "name" field in Recipe');
    }

    // Validate the 'ingredients' field
    if (json['ingredients'] == null || json['ingredients'] is! List) {
      throw ArgumentError('Invalid or missing "ingredients" field in Recipe');
    }

    // Validate the 'method' field
    if (json['method'] == null || json['method'] is! List) {
      throw ArgumentError('Invalid or missing "method" field in Recipe');
    }

    return Recipe(
      name: json['name'],
      ingredients: (json['ingredients'] as List)
          .map((ingredient) => Ingredient.fromJson(ingredient))
          .toList(),
      method: List<String>.from(json['method']),
    );
  }

  // Convert Recipe to JSON (useful for saving or sending data)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'method': method,
    };
  }
}



