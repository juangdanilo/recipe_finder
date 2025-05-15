import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/models/recipe.dart';
import 'package:recipe_finder/presentation/widgets/recipe_card.dart';
import 'package:recipe_finder/presentation/widgets/recipe_detail_view.dart';
import 'package:recipe_finder/presentation/widgets/search_dialog.dart';
import 'package:recipe_finder/providers/recipe_provider.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      body: _buildBody(context, provider),
    );
  }

  Widget _buildBody(BuildContext context, RecipeProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading the recipes'),
            ElevatedButton(
              onPressed: provider.loadRecipes,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.recipes.isEmpty) {
      return const Center(child: Text('There are no recipes available'));
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          toolbarHeight: 40,
          backgroundColor: const Color(0xFFBAD8B6),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final top = constraints.biggest.height;
              final isCollapsed = top <= kToolbarHeight + 40;
              final opacity = ((top - 99) / (254 - 99)).clamp(0.0, 1.0);
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
                                'Find your favorite recipes',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: isCollapsed ? 40 : 0),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SearchDialog(
                                  title: 'Search Recipes',
                                  hintText: 'Search Ingredients or names',
                                  onSearch: (query) {
                                    // search logic here
                                    // provider.searchRecipes(query);
                                  },
                                ),
                              );
                            },
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
                onTap: () => showRecipeDetails(context, provider.recipes[index]),
                child: RecipeCard(recipe: provider.recipes[index]),
              ),
              childCount: provider.recipes.length,
            ),
          ),
        ),
      ],
    );
  }

  void showRecipeDetails(BuildContext context, Recipe recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 1.0,
          minChildSize: 0.95,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: true,
                  expandedHeight: 200,
                  leading: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                  ),
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
                      RecipeDetailView(recipe: recipe),
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
}