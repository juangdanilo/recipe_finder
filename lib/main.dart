import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/presentation/recipe_page.dart';
import 'package:recipe_finder/providers/recipe_provider.dart';
import 'package:recipe_finder/services/recipe_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeProvider(RecipeService())..loadRecipes(),
        ),
      ],
      child: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: RecipePage(),
      ),
    );
  }
}