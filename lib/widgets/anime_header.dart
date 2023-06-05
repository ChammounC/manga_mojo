import 'package:mangamojo/models/anime.dart';
import 'package:flutter/material.dart';

class AnimeHeader extends StatelessWidget {
  late final Anime animeData;
  AnimeHeader({required this.animeData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animeData.titleEnglish,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color:Color.fromRGBO(170, 170, 170, 1),
                ),
              ),
              const SizedBox(height: 2.5),
              Text(
                animeData.title,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(120, 120, 120, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              RichText(text: TextSpan(
                text:'Aired On:  ',
                style:  TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(170, 170, 170, 1),
                    fontWeight: FontWeight.w600,

                ),
                children: [
                  TextSpan(text:animeData.airingDate,style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(120, 120, 120, 1),
              ),),
                ]
              ),),
              const SizedBox(height: 5),
              RichText(text: TextSpan(
                  text:'Rated:  ',
                  style:  TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(170, 170, 170, 1),
                    fontWeight: FontWeight.w600,

                  ),
                  children: [
                    TextSpan(text:animeData.rating,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(120, 120, 120, 1),
                    ),),
                  ]
              ),),
              const SizedBox(height: 5),
              RichText(text: TextSpan(
                  text:'No. of Episodes:  ',
                  style:  TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(170, 170, 170, 1),
                    fontWeight: FontWeight.w600,

                  ),
                  children: [
                    TextSpan(text:animeData.episodes <= 0
                        ? 'Ongoing'
                        : animeData.episodes.toString(),style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(120, 120, 120, 1),
                    ),),
                  ]
              ),),
              const SizedBox(height: 5),
              RichText(text: TextSpan(
                  text:'Studios:  ',
                  style:  TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(170, 170, 170, 1),
                    fontWeight: FontWeight.w600,

                  ),
                  children: [
                    TextSpan(text:animeData.studios,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(120, 120, 120, 1),
                    ),),
                  ]
              ),),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '${animeData.score}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color:Color.fromRGBO(170, 170, 170, 1),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: const Color.fromRGBO(255, 222, 89, 1),
                    backgroundColor:const Color.fromRGBO(170, 170, 170, 1).withOpacity(0.35),
                    strokeWidth: 6.0,
                    value: animeData.score / 10,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                animeData.rank != 0
                    ? 'Ranked\n #${animeData.rank}'
                    : 'Ranked\n N/A',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color:Color.fromRGBO(170, 170, 170, 1),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}