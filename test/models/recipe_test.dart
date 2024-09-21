import 'package:flutter_test/flutter_test.dart';
import 'package:my_recipe_app/models/recipe.dart';
import 'package:import 'package:flutter_test/flutter_test.dart';
import 'package:okraKale_recipe_app/models/recipe.dart';
import 'package:okraKale_recipe_app/models/ingredient.dart';

void main() {
  group('Recipe Model', () {
    test('Recipe model should be correctly created from JSON', () {
      // Arrange
      final json = {
        'name': 'Pancakes',
        'ingredients': [
          {'item': 'Flour', 'quantity': '1 cup'},
          {'item': 'Milk', 'quantity': '1/2 cup'}
        ],
        'method': [
          'Mix ingredients',
          'Cook on griddle'
        ]
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.name, 'Pancakes');
      expect(recipe.ingredients.length, 2);
      expect(recipe.ingredients[0].item, 'Flour');
      expect(recipe.method[0], 'Mix ingredients');
    });

    test('Recipe with no method steps should still work', () {
      // Arrange
      final json = {
        'name': 'Simple Salad',
        'ingredients': [
          {'item': 'Lettuce', 'quantity': '1 cup'},
        ],
        'method': []
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.name, 'Simple Salad');
      expect(recipe.ingredients.length, 1);
      expect(recipe.method.isEmpty, true); // Method list is empty but valid
    });

    test('Recipe with no ingredients should throw error', () {
      // Arrange
      final json = {
        'name': 'Empty Recipe',
        'ingredients': [],
        'method': ['Do nothing']
      };

      // Assert
      expect(() => Recipe.fromJson(json), throwsA(isA<Error>()));
    });

    test('Recipe with no name should throw error', () {
      // Arrange
      final json = {
        'ingredients': [
          {'item': 'Flour', 'quantity': '1 cup'}
        ],
        'method': ['Mix ingredients']
      };

      // Assert
      expect(() => Recipe.fromJson(json), throwsA(isA<Error>()));
    });

    test('Recipe with empty JSON should throw error', () {
      // Arrange
      final emptyJson = {};

      // Assert
      expect(() => Recipe.fromJson(emptyJson), throwsA(isA<Error>()));
    });
  });
}
/models/ingredient.dart';

void main() {
  group('Recipe Model', () {
    test('Recipe model should be correctly created from JSON', () {
      // Arrange
      final json = {
        'name': 'Pancakes',
        'ingredients': [
          {'item': 'Flour', 'quantity': '1 cup'},
          {'item': 'Milk', 'quantity': '1/2 cup'}
        ],
        'method': [
          'Mix ingredients',
          'Cook on griddle'
        ]
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.name, 'Pancakes');
      expect(recipe.ingredients.length, 2);
      expect(recipe.ingredients[0].item, 'Flour');
      expect(recipe.method[0], 'Mix ingredients');
    });

    test('Recipe with no method steps should still work', () {
      // Arrange
      final json = {
        'name': 'Simple Salad',
        'ingredients': [
          {'item': 'Lettuce', 'quantity': '1 cup'},
        ],
        'method': []
      };

      // Act
      final recipe = Recipe.fromJson(json);

      // Assert
      expect(recipe.name, 'Simple Salad');
      expect(recipe.ingredients.length, 1);
      expect(recipe.method.isEmpty, true); // Method list is empty but valid
    });

    test('Recipe with no ingredients should throw error', () {
      // Arrange
      final json = {
        'name': 'Empty Recipe',
        'ingredients': [],
        'method': ['Do nothing']
      };

      // Assert
      expect(() => Recipe.fromJson(json), throwsA(isA<Error>()));
    });

    test('Recipe with no name should throw error', () {
      // Arrange
      final json = {
        'ingredients': [
          {'item': 'Flour', 'quantity': '1 cup'}
        ],
        'method': ['Mix ingredients']
      };

      // Assert
      expect(() => Recipe.fromJson(json), throwsA(isA<Error>()));
    });

    test('Recipe with empty JSON should throw error', () {
      // Arrange
      final emptyJson = {};

      // Assert
      expect(() => Recipe.fromJson(emptyJson), throwsA(isA<Error>()));
    });
  });
}
