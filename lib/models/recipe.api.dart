import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    final uri = Uri.https('low-carb-recipes.p.rapidapi.com', '/search', {
      "name": "cake",
      "tags": "keto",
      "limit": "10",
    });

    final response = await http.get(
      uri,
      headers: {
        "x-rapidapi-key": "API KEY HERE",
        "x-rapidapi-host": "low-carb-recipes.p.rapidapi.com",
      },
    );

    List<dynamic> data = jsonDecode(response.body);

    // Convertir la lista dinámica a una lista de mapas y usar recipesFromSnapshot
    return Recipe.recipesFromSnapshot(data.cast<Map<String, dynamic>>());
  }
}