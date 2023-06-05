class Recommendation {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  Recommendation({
    this.malId = 1,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      malId: json['entry']['mal_id'] ?? 1,
      url: json['entry']['url'] ?? '',
      imageUrl: json['entry']['images']['jpg']['image_url'] ?? '',
      title: json['entry']['title'] ?? '',
    );
  }
}