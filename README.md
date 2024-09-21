# flutter-generator

Recipe App Generator written and tested natively with on Flutter using Dart.


**Project File Structure**:

# Recipe App File Structure

```bash
okraKale_recipe_app/
├── android/
├── ios/
├── assets/
│   └── recipes/               # JSON files (put your recipe JSON files here)
├── lib/
│   ├── main.dart              # Entry point of the Flutter app
│   ├── models/                # Data models for the app
│   │   ├── ingredient.dart    # Ingredient model
│   │   └── recipe.dart        # Recipe model
│   ├── screens/               # UI screens
│   │   ├── ingredient_input_screen.dart  # Ingredient input UI
│   │   ├── recipe_detail_screen.dart     # Recipe detail UI
│   │   └── recipe_list_screen.dart       # List of recipes
│   └── services/              # Business logic (e.g., parsing JSON, filtering recipes)
│       └── recipe_service.dart # Recipe-related functions
├── pubspec.yaml               # Project config, including dependencies and assets
├── test/                      # Unit tests
└── assets/
    └── images/                # Any image assets (optional)
```

## Core Features

1. **Ingredient Input** : Users can input and manage a list of ingredients.
2. **Recipe Browsing** : Recipes can be filtered based on available ingredients.
3. **Recipe Details** : Each recipe includes instructions and tips.
4. **Minimizing Food Waste** : Prioritize recipes using available ingredients.
5. **Notifications** : Notify users when new recipes matching their ingredients are added.
6. **User Tips** : Include tips and ingredient substitutions.

### **How to Run Unit Tests**

1. **Run tests with the following command in the root of your Flutter project:**

```bash

   flutter test
```
2. **Ensure you have the** `flutter_test` **dependency in your** `pubspec.yaml`:

```bash
   dev_dependencies:
     mockito: ^5.0.16
     flutter_launcher_icons: ^0.9.2
     flutter_test:
       sdk: flutter
```

## Explanation of the Unit Tests

1. **Ingredient Model Test (`ingredient_test.dart`)** :

* Ensures the `Ingredient` model is correctly created from JSON.
* Tests if the model throws an error when there is incomplete JSON data (missing fields).

2. **Recipe Model Test (`recipe_test.dart`)** :

* Tests the `Recipe` model to ensure it can properly parse JSON data, including handling empty method steps.

3. **Recipe Service Test (`recipe_service_test.dart`)** :

* Tests if the service correctly loads recipes from a mocked JSON file.
* Tests the filtering logic to ensure that recipes matching a list of ingredients are correctly returned.
