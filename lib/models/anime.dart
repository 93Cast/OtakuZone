class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final double? score;
  final int? episodes;
  final String? synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.score,
    this.episodes,
    this.synopsis,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'] ?? 'Sin título',
      imageUrl: json['images']['jpg']['image_url'],
      score: json['score']?.toDouble(),
      episodes: json['episodes'],
      synopsis: json['synopsis'],
    );
  }
}
