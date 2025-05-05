import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipe_finder/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              recipe.image,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            (random.nextDouble() * 3.0 + 2).toStringAsFixed(1),
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Cook time at the bottom left
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      recipe.totalTime.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}