import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/anime.dart';

class JikanService {
  static const String baseUrl =
      'https://api.jikan.moe/v4';

  // =====================================================
  // OBTENER ANIMES POPULARES
  // =====================================================

  Future<List<Anime>> getTopAnime() async {
    final uri = Uri.parse(
      '$baseUrl/top/anime',
    );

    final response = await http
        .get(uri)
        .timeout(
          const Duration(seconds: 15),
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> animeJson =
          data['data'];

      return animeJson
          .map(
            (anime) => Anime.fromJson(anime),
          )
          .toList();
    }

    throw Exception(
      'Error ${response.statusCode}: '
      'No se pudieron obtener los animes.',
    );
  }

  // =====================================================
  // BUSCAR ANIME
  // =====================================================

  Future<List<Anime>> searchAnime(
    String query,
  ) async {
    final uri = Uri.parse(
      '$baseUrl/anime',
    ).replace(
      queryParameters: {
        'q': query,
        'limit': '10',
      },
    );

    try {
      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 15),
          );

      // -----------------------------------------------
      // OK
      // -----------------------------------------------

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> animeJson =
            data['data'];

        return animeJson
            .map(
              (anime) => Anime.fromJson(anime),
            )
            .toList();
      }

      // -----------------------------------------------
      // TOO MANY REQUESTS
      // -----------------------------------------------

      if (response.statusCode == 429) {
        throw Exception(
          'Demasiadas búsquedas. '
          'Espera unos segundos e inténtalo nuevamente.',
        );
      }

      // -----------------------------------------------
      // GATEWAY TIMEOUT
      // -----------------------------------------------

      if (response.statusCode == 504) {
        throw Exception(
          'Jikan tardó demasiado en responder. '
          'Espera unos segundos e inténtalo nuevamente.',
        );
      }

      // -----------------------------------------------
      // SERVICE UNAVAILABLE
      // -----------------------------------------------

      if (response.statusCode == 503) {
        throw Exception(
          'Jikan no está disponible temporalmente. '
          'Inténtalo nuevamente en unos segundos.',
        );
      }

      // -----------------------------------------------
      // OTROS ERRORES
      // -----------------------------------------------

      throw Exception(
        'Error ${response.statusCode}',
      );
    } on Exception catch (e) {
      // Mantener nuestros mensajes personalizados
      if (e.toString().contains(
            'Demasiadas búsquedas',
          ) ||
          e.toString().contains(
            'Jikan tardó',
          ) ||
          e.toString().contains(
            'Jikan no está disponible',
          )) {
        rethrow;
      }

      throw Exception(
        'No se pudo conectar con Jikan. '
        'Comprueba tu conexión e inténtalo nuevamente.',
      );
    }
  }

  // =====================================================
  // OBTENER ANIME POR ID
  // =====================================================

  Future<Anime> getAnimeById(
    int id,
  ) async {
    final uri = Uri.parse(
      '$baseUrl/anime/$id',
    );

    final response = await http
        .get(uri)
        .timeout(
          const Duration(seconds: 15),
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Anime.fromJson(
        data['data'],
      );
    }

    throw Exception(
      'Error ${response.statusCode}: '
      'No se pudo obtener el anime.',
    );
  }
} 