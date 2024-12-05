class Anime{
  final int head;
  final String character;
  final String imageUrl;
  final String gameSeries;

  Anime ({
    required this.head,
    required this.character,
    required this.imageUrl,
    required this.gameSeries
  });

  factory Anime.fromJson(Map<String, dynamic> json){
    return Anime(
      head: json['head'] ?? 0,
      character: json ['amiiboSeries'] ?? "",
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
        ?json['images'] [0]
        : 'https://placehold.co/600x400',
      gameSeries: (json['character'] != null)
        ?(json['gameSeries']?? "Game Series Empty")
        : "gaada series "
      );
  }
}
  