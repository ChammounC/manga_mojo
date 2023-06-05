import 'package:mangamojo/models/anime.dart';
import 'package:flutter/material.dart';

class GenreDetails extends StatelessWidget {
  late final Anime animeData;
  BuildContext context;
  GenreDetails({required this.animeData,required this.context});

  Widget moveLabel(String text, dynamic pokeData) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).secondaryHeaderColor)
      ),
      child: Center(
        child: Text(
          text,
          style:  TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(150, 150, 150, 1),
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List genreList = animeData.genres;
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      childAspectRatio: 6 / 1.5,
      crossAxisSpacing: 4,
      children: genreList.map((item) => moveLabel(item, animeData)).toList(),
    );
  }
}