// lib/presentation/widgets/recipe_detail_view.dart
import 'package:flutter/material.dart';
import 'package:recipe_finder/models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          //const SizedBox(height: 12),
          //Image.network(recipe.image, height: 180, fit: BoxFit.cover),
          const SizedBox(height: 12),
          Text('Total Time: ${recipe.totalTime} min', style: const TextStyle(fontSize: 16)),
          Text('Prep: ${recipe.prepareTime} min | Cook: ${recipe.cookTime} min', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 12),
          Text('Servings: ${recipe.servings}', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          if (recipe.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              children: recipe.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          const SizedBox(height: 12),
          Text(recipe.description, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          Text('Ingredients:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ...recipe.ingredients.map((i) => Text('- ${i.name} (${i.servingSize.grams}g)')),
          const SizedBox(height: 16),
          Text('Steps:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ...recipe.steps.asMap().entries.map((e) => Text('${e.key + 1}. ${e.value}')),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}