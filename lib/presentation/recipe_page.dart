import 'package:flutter/material.dart';
import 'package:recipe_finder/models/recipe.api.dart';
import 'package:recipe_finder/models/recipe.dart';
import 'package:recipe_finder/presentation/widgets/recipe_card.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: _recipes[index],
          );
        });
  }
}