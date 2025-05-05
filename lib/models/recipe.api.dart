import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    final uri = Uri.https('run.mocky.io', '/v3/20208f35-57f0-4261-a78a-7769f090e214');

    final response = await http.get(
      uri
    );

    List<dynamic> data = jsonDecode(response.body);

    // Convertir la lista dinámica a una lista de mapas y usar recipesFromSnapshot
    return Recipe.recipesFromSnapshot(data.cast<Map<String, dynamic>>());
  }
}