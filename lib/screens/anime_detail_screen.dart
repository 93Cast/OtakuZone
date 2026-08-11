import 'package:flutter/material.dart';

import '../models/anime.dart';

class AnimeDetailScreen extends StatelessWidget {

  final Anime anime;

  const AnimeDetailScreen({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Detalle del anime'),
      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

           Center(
  child: Image.network(
    anime.imageUrl,
    height: 350,
    width: MediaQuery.of(context).size.width * 0.5,
    fit: BoxFit.contain,
  ),
),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Text(
                anime.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),

            Text(
              '⭐ ${anime.score ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '📺 ${anime.episodes ?? 'Desconocido'} episodios',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    'Sinopsis',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    anime.synopsis ??
                        'No hay sinopsis disponible.',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}