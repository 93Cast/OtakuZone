import 'package:flutter/material.dart';

import '../models/anime.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // IMAGEN
          // ==========================================

          SizedBox(
            width: double.infinity,
            height: 180,
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 50,
                  ),
                );
              },
              loadingBuilder: (
                context,
                child,
                loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          // ==========================================
          // INFORMACIÓN DEL ANIME
          // ==========================================

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      anime.score != null
                          ? anime.score!
                              .toStringAsFixed(1)
                          : 'N/A',
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