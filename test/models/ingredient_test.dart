import 'package:flutter_test/flutter_test.dart';
import 'package:okraKale_recipe_app/models/ingredient.dart';

void main() {
  group('Ingredient Model', () {
    test('Ingredient model should be correctly created from JSON', () {
      // Arrange
      final json = {'item': 'Sugar', 'quantity': '2 cups'};

      // Act
      final ingredient = Ingredient.fromJson(json);

      // Assert
      expect(ingredient.item, 'Sugar');
      expect(ingredient.quantity, '2 cups');
    });

    test('Ingredient model should throw error if missing fields', () {
      // Arrange
      final incompleteJson = {'item': 'Salt'};

      // Assert
      expect(() => Ingredient.fromJson(incompleteJson), throwsA(isA<Error>()));
    });

    test('Ingredient model should throw error for empty JSON', () {
      // Arrange
      final emptyJson = {};

      // Assert
      expect(() => Ingredient.fromJson(emptyJson), throwsA(isA<Error>()));
    });
  });
}
