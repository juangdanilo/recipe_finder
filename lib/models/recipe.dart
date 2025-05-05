class Recipe {
  final String name;
  final String image;
  //final double rating;
  final int totalTime;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      totalTime: json['prepareTime'],
      image: json['image']
    );
  }

  Recipe(
      {required this.name,
        required this.image,
        //required this.rating,
        required this.totalTime});
  
  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $image, totalTime: $totalTime}';
  }
}