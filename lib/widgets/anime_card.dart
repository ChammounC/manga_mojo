import 'package:mangamojo/models/card.dart';
import 'package:mangamojo/views/anime_details.dart';
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final CardModel homeData;
  final int cardIndex;

  AnimeCard({
    required this.homeData,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    // final device = MediaQuery.of(context);
    // final screenHeight = device.size.height;
    // final screenWidth = device.size.width;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AnimeDetails.routeName,
        arguments: homeData.malId,
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: homeData.malId,
                child: Image.network(
                  homeData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    homeData.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color:Color.fromRGBO(200, 200, 200, 1)
                    ),
                  ),
                ),
                IconButton(
                  icon:  Icon(
                    Icons.bookmark_outline,
                    color:Theme.of(context).secondaryHeaderColor
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}