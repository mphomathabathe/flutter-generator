import 'package:flutter_test/flutter_test.dart';
import 'okraKale_recipe_app/models/recipe.dart';
import 'okraKale_recipe_app/services/recipe_service.dart';

void main() {
  group('Recipe Service', () {
    test('loadRecipes should correctly parse JSON data', () async {
      // Mock JSON string for testing
      const mockJson = '''
      {
        "recipes": [
          {
            "name": "Simple Pancakes",
            "ingredients": [
              {"item": "Flour", "quantity": "1 cup"},
              {"item": "Milk", "quantity": "1 cup"}
            ],
            "method": ["Mix ingredients", "Cook on a pan"]
          }
        ]
      }
      ''';

      // Simulate loadRecipes (you could use mock for `rootBundle` in a real app)
      final jsonData = {
        "recipes": [
          {
            "name": "Simple Pancakes",
            "ingredients": [
              {"item": "Flour", "quantity": "1 cup"},
              {"item": "Milk", "quantity": "1 cup"}
            ],
            "method": ["Mix ingredients", "Cook on a pan"]
          }
        ]
      };

      // Act
      final recipes = jsonData['recipes'].map((recipe) => Recipe.fromJson(recipe)).toList();

      // Assert
      expect(recipes.length, 1);
      expect(recipes[0].name, 'Simple Pancakes');
      expect(recipes[0].ingredients[0].item, 'Flour');
      expect(recipes[0].method[0], 'Mix ingredients');
    });

    test('filterRecipesByIngredients should return correct recipes', () {
      // Arrange: Mock recipe list
      final recipes = [
        Recipe(
          name: 'Smoothie',
          ingredients: [Ingredient(item: 'Banana', quantity: '1'), Ingredient(item: 'Milk', quantity: '1 cup')],
          method: ['Blend ingredients'],
        ),
        Recipe(
          name: 'Omelette',
          ingredients: [Ingredient(item: 'Eggs', quantity: '2'), Ingredient(item: 'Salt', quantity: 'pinch')],
          method: ['Cook on pan'],
        ),
      ];

      // Act: Filter by ingredients that only match one recipe
      final filteredRecipes = filterRecipesByIngredients(recipes, ['banana', 'milk']);

      // Assert: Only one recipe should be matched
      expect(filteredRecipes.length, 1);
      expect(filteredRecipes[0].name, 'Smoothie');
    });
  });
}
