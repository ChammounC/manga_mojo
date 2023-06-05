class Anime {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;
  late String trailerUrl;
  late String titleEnglish;
  late String synopsis;
  late String status;
  late dynamic episodes;
  late String duration;
  late String rating;
  late dynamic score;
  late dynamic rank;
  late String airingDate;
  late dynamic genres;
  late dynamic genreId;
  late dynamic studios;

  Anime({
    this.malId = 0,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
    this.trailerUrl = '',
    this.titleEnglish = '',
    this.synopsis = '',
    this.status = '',
    this.episodes = 0,
    this.duration = '',
    this.rating = '',
    this.score = 0,
    this.rank = 0,
    this.airingDate = '',
    this.genres = const [],
    this.genreId = 1,
    this.studios='',
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    List genresList = json['genres'];
    List studiosList = json['studios'];
    String titleEnglish=json['titles'][0]['title'];
    String title=json['titles'][0]['title'];
    String synopsis = json['synopsis'].replaceAll('[Written by MAL Rewrite]','');
    String airedOn = json['aired']['string'].substring(0,json['aired']['string'].indexOf('to'));
    for(int i=0;i<json['titles'].length;i++){
      if(json['titles'][i]['type'].toLowerCase()=='english'){
        titleEnglish=json['titles'][i]['title'];
      }
      if(json['titles'][i]['type'].toLowerCase()=='japanese'){
        title=json['titles'][i]['title'];
      }
    }
    List genres = [];
    for (int i = 0; i < genresList.length; i++) {
      genres.add(json['genres'][i]['name']);
    }
    String studios=json['studios'][0]['name'];
    for(int i = 1;i<studiosList.length;i++){
      studios+=', ${json['studios'][i]['name']}';
    }

    return Anime(
      malId: json['mal_id'] ?? 0,
      url: json['url'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      title: title,
      trailerUrl: json['trailer']['url'] ?? '',
      titleEnglish: titleEnglish,
      synopsis: synopsis ?? '',
      status: json['status'] ?? '',
      episodes: json['episodes'] ?? 0,
      duration: json['duration'] ?? '',
      rating: json['rating'] ?? '',
      score: json['score'] ?? 0,
      rank: json['rank'] ?? 0,
      airingDate: airedOn ?? '',
      genres: genres,
      genreId: json['genres'][0]['mal_id'],
      studios:studios,
    );
  }
}