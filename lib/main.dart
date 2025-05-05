import 'package:flutter/material.dart';
import 'package:recipe_finder/presentation/recipe_page.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Recipe Finder", style: TextStyle(color: Colors.white)),
                background: Image.network(
                  'https://example.com/your_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFillRemaining(

            ),
            SliverToBoxAdapter(
              child: const RecipePage(),
            ),
          ],
        )
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: const Text("Recipe Finder"),
        // ),
        // body: const RecipePage(),
      ),
    );
  }
}