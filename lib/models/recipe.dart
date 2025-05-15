class ServingSize {
  final double grams;

  ServingSize({required this.grams});

  factory ServingSize.fromJson(Map<String, dynamic> json) {
    return ServingSize(
      grams: (json['grams'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Ingredient {
  final String name;
  final ServingSize servingSize;

  Ingredient({required this.name, required this.servingSize});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      servingSize: ServingSize.fromJson(json['servingSize'] ?? {}),
    );
  }
}

class Recipe {
  final String id;
  final String name;
  final List<String> tags;
  final String description;
  final int prepareTime;
  final int cookTime;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final int servings;
  final String image;

  Recipe({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.prepareTime,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
    required this.servings,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      description: json['description'] ?? '',
      prepareTime: json['prepareTime'] ?? 0,
      cookTime: json['cookTime'] ?? 0,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((i) => Ingredient.fromJson(i))
          .toList() ?? [],
      steps: (json['steps'] as List<dynamic>?)?.cast<String>() ?? [],
      servings: json['servings'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Recipe.fromJson(data)).toList();
  }

  // Helper getter for total time
  int get totalTime => prepareTime + cookTime;

  @override
  String toString() {
    return 'Recipe {id: $id, name: $name, totalTime: $totalTime}';
  }
}