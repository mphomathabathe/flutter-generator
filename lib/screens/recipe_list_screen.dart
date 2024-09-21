import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import 'package:url_launcher/url_launcher.dart'; // To open external URLs

class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String>? userIngredients = ModalRoute.of(context)?.settings.arguments as List<String>?;

    if (userIngredients == null || userIngredients.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("No Ingredients")),
        body: Center(child: Text("No ingredients provided to filter recipes.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Matching Recipes")),
      body: FutureBuilder<List<Recipe>>(
        future: loadAllRecipes(), // Load all recipes from the JSON files
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading recipes.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found.'));
          }

          final recipes = snapshot.data!;
          final filteredRecipes = filterRecipesByIngredients(recipes, userIngredients);

          if (filteredRecipes.isEmpty) {
            // Suggest a close-matching recipe and invite to premium feature
            final suggestedRecipe = suggestCloseRecipe(recipes, userIngredients);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No exact matches found for your selected ingredients.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () => _launchURL('https://yourpremiumsubscription.com'),
                    child: Text('Upgrade to Premium for More Recipes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Try this recipe in the meantime:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (suggestedRecipe != null)
                  ListTile(
                    leading: Image.asset(
                      'assets/images/recipes/${suggestedRecipe.name.toLowerCase().replaceAll(' ', '_')}_icon.png',
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.fastfood, size: 50); // Fallback icon
                      },
                    ),
                    title: Text(suggestedRecipe.name),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/recipeDetail',
                        arguments: suggestedRecipe,
                      );
                    },
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No close matching recipes found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ), // Fallback in case no similar recipe is found
              ],
            );
          }

          return ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = filteredRecipes[index];
              return ListTile(
                leading: Image.asset(
                  'assets/images/recipes/${recipe.name.toLowerCase().replaceAll(' ', '_')}_icon.png',
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.fastfood, size: 50); // Fallback icon
                  },
                ),
                title: Text(recipe.name),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/recipeDetail',
                    arguments: recipe,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Function to launch external URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
