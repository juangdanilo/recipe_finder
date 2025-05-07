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

  void _showRecipeDetails(Recipe recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: true,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tiempo total: ${recipe.totalTime} minutos',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
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
          pinned: true,
          expandedHeight: 200,
          toolbarHeight: 40,
          backgroundColor: Color(0xFFBAD8B6),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final top = constraints.biggest.height;
              final isCollapsed = top <= kToolbarHeight + 40;
              final opacity = ((top - 94) / (254 - 94)).clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: opacity,
                              child: const Text(
                                'Welcome Back!',
                                style: TextStyle(fontSize: 24, color: Colors.black87),
                              ),
                            ),
                            Opacity(
                              opacity: opacity,
                              child: const Text(
                                'Find your favorite recipe',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: isCollapsed ? 40 : 0),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search_outlined),
                            color: const Color(0xFFE1EACD),
                            iconSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => GestureDetector(
                onTap: () => _showRecipeDetails(_recipes[index]),
                //padding: const EdgeInsets.only(bottom: 12),
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