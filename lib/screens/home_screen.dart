import 'package:flutter/material.dart';

import '../models/anime.dart';
import '../services/jikan_service.dart';
import '../widgets/anime_card.dart';
import '../widgets/loading_widget.dart';

import 'anime_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final JikanService service = JikanService();

  List<Anime> animes = [];

  bool isLoading = true;

  String? error;

  @override
  void initState() {
    super.initState();

    loadAnime();
  }

  // =====================================================
  // CARGAR ANIMES
  // =====================================================

  Future<void> loadAnime() async {
    try {
      final result =
          await service.getTopAnime();

      if (!mounted) {
        return;
      }

      setState(() {
        animes = result;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
        error =
            'No se pudieron cargar los animes';
      });
    }
  }

  // =====================================================
  // PANTALLA
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OtakuZone',
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const SearchScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
            tooltip: 'Buscar anime',
          ),
        ],
      ),

      body: buildBody(),
    );
  }

  // =====================================================
  // CONTENIDO PRINCIPAL
  // =====================================================

  Widget buildBody() {
    // ---------------------------------------------------
    // CARGANDO
    // ---------------------------------------------------

    if (isLoading) {
      return const LoadingWidget();
    }

    // ---------------------------------------------------
    // ERROR
    // ---------------------------------------------------

    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
            ),

            const SizedBox(height: 12),

            Text(
              error!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: loadAnime,
              child: const Text(
                'Reintentar',
              ),
            ),
          ],
        ),
      );
    }

    // ---------------------------------------------------
    // GRID RESPONSIVO
    // ---------------------------------------------------

    return GridView.builder(
      padding: const EdgeInsets.all(12),

      gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
        // Ancho máximo aproximado de cada tarjeta
        maxCrossAxisExtent: 220,

        // Separación horizontal
        crossAxisSpacing: 12,

        // Separación vertical
        mainAxisSpacing: 12,

        // Relación ancho / alto
        childAspectRatio: 0.65,
      ),

      itemCount: animes.length,

      itemBuilder: (context, index) {
        final anime = animes[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AnimeDetailScreen(
                  anime: anime,
                ),
              ),
            );
          },

          child: AnimeCard(
            anime: anime,
          ),
        );
      },
    );
  }
}