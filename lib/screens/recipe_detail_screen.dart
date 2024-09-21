import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the recipe object passed via the arguments
    final recipe = ModalRoute.of(context)?.settings.arguments as Recipe?;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Recipe details not available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          overflow: TextOverflow.ellipsis, // Avoid overflow for long titles
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ingredients Section
              Text(
                'Ingredients:',
                style: Theme.of(context).textTheme.headline6, // Use the app's text theme
              ),
              SizedBox(height: 8), // Add spacing between title and content
              ...recipe.ingredients.map((ing) => Text(
                '• ${ing.quantity} ${ing.item}',
                style: Theme.of(context).textTheme.bodyText1, // Consistent text style
              )).toList(),
              SizedBox(height: 16),

              // Method Section
              Text(
                'Method:',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              ...recipe.method.asMap().entries.map((entry) {
                int stepIndex = entry.key + 1;
                String step = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '$stepIndex. $step',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }).toList(), // Numbered method steps
              
              SizedBox(height: 16), // Final spacing before end of the content
            ],
          ),
        ),
      ),
    );
  }
}
