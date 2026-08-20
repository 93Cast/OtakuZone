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
    final colorScheme =
        Theme.of(context).colorScheme;

    return Scaffold(
      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        title: const Text(
          'Detalle del anime',
        ),
      ),

      // =====================================================
      // CONTENIDO
      // =====================================================

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [
            // =================================================
            // IMAGEN
            // =================================================

            const SizedBox(height: 20),

            Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12),

                child: Image.network(
                  anime.imageUrl,

                  height: 350,

                  width:
                      MediaQuery.of(context)
                              .size
                              .width *
                          0.5,

                  fit: BoxFit.contain,

                  // -----------------------------------------
                  // IMAGEN DE CARGA
                  // -----------------------------------------

                  loadingBuilder:
                      (
                        context,
                        child,
                        loadingProgress,
                      ) {
                        if (loadingProgress ==
                            null) {
                          return child;
                        }

                        return SizedBox(
                          height: 350,
                          child: Center(
                            child:
                                CircularProgressIndicator(
                              value:
                                  loadingProgress
                                              .expectedTotalBytes !=
                                          null
                                      ? loadingProgress
                                              .cumulativeBytesLoaded /
                                          loadingProgress
                                              .expectedTotalBytes!
                                      : null,
                            ),
                          ),
                        );
                      },

                  // -----------------------------------------
                  // ERROR DE IMAGEN
                  // -----------------------------------------

                  errorBuilder:
                      (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const SizedBox(
                          height: 350,
                          child: Center(
                            child: Icon(
                              Icons
                                  .broken_image_outlined,
                              size: 70,
                            ),
                          ),
                        );
                      },
                ),
              ),
            ),

            // =================================================
            // TÍTULO
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                24,
                16,
                16,
              ),

              child: Text(
                anime.title,

                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),

                textAlign: TextAlign.center,
              ),
            ),

            // =================================================
            // INFORMACIÓN
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  // -------------------------------------------
                  // PUNTUACIÓN
                  // -------------------------------------------

                  _InfoItem(
                    icon: Icons.star,
                    iconColor:
                        colorScheme.primary,

                    text:
                        '${anime.score ?? 'N/A'}',
                  ),

                  const SizedBox(width: 24),

                  // -------------------------------------------
                  // EPISODIOS
                  // -------------------------------------------

                  _InfoItem(
                    icon: Icons.tv,
                    iconColor:
                        colorScheme.secondary,

                    text:
                        '${anime.episodes ?? 'Desconocido'} episodios',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // SINOPSIS
            // =================================================

            Padding(
              padding: const EdgeInsets.all(16),

              child: Card(
                elevation: 0,

                color: colorScheme
                    .surfaceContainerHighest,

                child: Padding(
                  padding:
                      const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      // ---------------------------------------
                      // TÍTULO
                      // ---------------------------------------

                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color:
                                colorScheme.primary,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          Text(
                            'Sinopsis',

                            style: Theme.of(
                                    context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ---------------------------------------
                      // TEXTO
                      // ---------------------------------------

                      Text(
                        anime.synopsis ??
                            'No hay sinopsis disponible.',

                        style: Theme.of(
                                context)
                            .textTheme
                            .bodyLarge,

                        textAlign:
                            TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// WIDGET PARA INFORMACIÓN
// =========================================================

class _InfoItem extends StatelessWidget {
  final IconData icon;

  final Color iconColor;

  final String text;

  const _InfoItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),

        const SizedBox(width: 6),

        Text(
          text,

          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(
                fontWeight:
                    FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
