import 'package:recipe_finder/models/recipe.dart';
import 'package:recipe_finder/models/recipe.api.dart';

class RecipeService {
  Future<List<Recipe>> fetchRecipes() async {
    return await RecipeApi.getRecipe();
  }
}