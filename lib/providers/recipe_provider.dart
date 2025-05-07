import 'package:flutter/material.dart';
import 'package:recipe_finder/models/recipe.dart';
import 'package:recipe_finder/services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeService _service;
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  bool _hasError = false;

  RecipeProvider(this._service);

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> loadRecipes() async {
    try {
      _recipes = await _service.fetchRecipes();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}