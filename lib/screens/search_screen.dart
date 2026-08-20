import 'dart:async';

import 'package:flutter/material.dart';

import '../models/anime.dart';
import '../services/jikan_service.dart';
import '../widgets/anime_card.dart';

import 'anime_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // =====================================================
  // SERVICIO
  // =====================================================

  final JikanService service = JikanService();

  // =====================================================
  // CONTROLADOR DEL CAMPO DE BÚSQUEDA
  // =====================================================

  final TextEditingController controller =
      TextEditingController();

  // =====================================================
  // DEBOUNCE
  // =====================================================

  Timer? _debounce;

  // =====================================================
  // RESULTADOS
  // =====================================================

  List<Anime> results = [];

  // =====================================================
  // ESTADOS
  // =====================================================

  bool isLoading = false;

  String? error;

  // Identificador de búsqueda.
  //
  // Sirve para evitar que una respuesta antigua
  // sobrescriba los resultados de una búsqueda nueva.
  int _searchId = 0;

  // =====================================================
  // CUANDO CAMBIA EL TEXTO
  // =====================================================

  void onSearchChanged(String query) {
    // Cancelar el Timer anterior
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    final text = query.trim();

    // ===================================================
    // CAMPO VACÍO
    // ===================================================

    if (text.isEmpty) {
      _searchId++;

      setState(() {
        results = [];
        error = null;
        isLoading = false;
      });

      return;
    }

    // ===================================================
    // MENOS DE 3 CARACTERES
    // ===================================================

    if (text.length < 3) {
      setState(() {
        results = [];
        error = null;
        isLoading = false;
      });

      return;
    }

    // ===================================================
    // DEBOUNCE
    // ===================================================

    _debounce = Timer(
      const Duration(milliseconds: 1000),
      () {
        searchAnime(text);
      },
    );
  }

  // =====================================================
  // BUSCAR ANIME
  // =====================================================

  Future<void> searchAnime(String query) async {
    // Crear un identificador para esta búsqueda
    final int currentSearchId = ++_searchId;

    if (!mounted) {
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result =
          await service.searchAnime(query);

      // -------------------------------------------------
      // Comprobar que esta búsqueda sigue siendo
      // la búsqueda actual
      // -------------------------------------------------

      if (currentSearchId != _searchId) {
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        results = result;
        isLoading = false;

        if (result.isEmpty) {
          error = 'No se encontraron animes';
        }
      });
    } catch (e) {
      // -------------------------------------------------
      // Ignorar respuestas de búsquedas anteriores
      // -------------------------------------------------

      if (currentSearchId != _searchId) {
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;

        error = e
            .toString()
            .replaceFirst(
              'Exception: ',
              '',
            );
      });
    }
  }

  // =====================================================
  // LIMPIAR BÚSQUEDA
  // =====================================================

  void clearSearch() {
    // Cancelar búsqueda pendiente
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Invalidar cualquier búsqueda anterior
    _searchId++;

    controller.clear();

    setState(() {
      results = [];
      error = null;
      isLoading = false;
    });
  }

  // =====================================================
  // LIBERAR RECURSOS
  // =====================================================

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();

    super.dispose();
  }

  // =====================================================
  // INTERFAZ
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title: const Text(
          'Buscar Anime',
        ),
      ),

      // =================================================
      // BODY
      // =================================================

      body: Column(
        children: [
          // =============================================
          // CAMPO DE BÚSQUEDA
          // =============================================

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,

              // Búsqueda en tiempo real
              onChanged: onSearchChanged,

              decoration: InputDecoration(
                hintText: 'Buscar anime...',

                border:
                    const OutlineInputBorder(),

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                // Botón para limpiar
                suffixIcon:
                    controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            onPressed:
                                clearSearch,
                          )
                        : null,
              ),
            ),
          ),

          // =============================================
          // INDICADOR DE CARGA
          // =============================================

          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: LinearProgressIndicator(),
            ),

          // =============================================
          // MENSAJE DE ERROR
          // =============================================

          if (error != null)
            Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

          // =============================================
          // RESULTADOS
          // =============================================

          Expanded(
            child:
                // ---------------------------------------
                // SIN RESULTADOS
                // ---------------------------------------

                results.isEmpty && !isLoading
                    ? Center(
                        child: Text(
                          controller.text
                                  .trim()
                                  .isEmpty
                              ? 'Escribe el nombre de un anime'
                              : error ??
                                  'No se encontraron animes',
                          textAlign:
                              TextAlign.center,
                          style:
                              const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )

                    // -----------------------------------
                    // GRID
                    // -----------------------------------

                    : GridView.builder(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        // Grid responsivo
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          // Cada tarjeta tendrá
                          // aproximadamente este
                          // ancho máximo
                          maxCrossAxisExtent: 220,

                          crossAxisSpacing: 12,

                          mainAxisSpacing: 12,

                          childAspectRatio: 0.65,
                        ),

                        itemCount:
                            results.length,

                        itemBuilder:
                            (context, index) {
                          final anime =
                              results[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
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
                      ),
          ),
        ],
      ),
    );
  }
} 