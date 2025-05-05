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
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      final recipes = await RecipeApi.getRecipe();
      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading recipes'),
            ElevatedButton(
              onPressed: getRecipes,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_recipes.isEmpty) {
      return const Center(child: Text('There are no recipes available'));
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          backgroundColor: const Color(0xFFBAD8B6),
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 24, color: Colors.black87),
                  ),
                  const Text(
                    'Find your favorite recipe',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Recipes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_outlined),
                        color: const Color(0xFFE1EACD),
                        iconSize: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          pinned: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: RecipeCard(recipe: _recipes[index]),
              ),
              childCount: _recipes.length,
            ),
          ),
        ),
      ],
    );
  }
}