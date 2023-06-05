class CardModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  CardModel({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    var engTitle=json['titles'][0]['title'];
    for(int i =0;i<json['titles'].length;i++){
      if(json['titles'][i]['type'].toLowerCase()=='english'){
        engTitle=json['titles'][i]['title'];
      }
    }
    return CardModel(
      malId: json['mal_id'],
      url: json['url'],
      imageUrl: json['images']['jpg']['image_url'],
      title: engTitle,
    );
  }
}