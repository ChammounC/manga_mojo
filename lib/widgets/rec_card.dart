import 'package:flutter/material.dart';
import 'package:mangamojo/models/recommendation.dart';
import 'package:mangamojo/views/anime_details.dart';

class RecommendationCard extends StatelessWidget {
  final Recommendation recData;

  RecommendationCard({
    required this.recData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNotMobile = screenWidth>600;
    return Container(
      width: isNotMobile?250:150,
      height:isNotMobile?300:null,
      margin:isNotMobile?const EdgeInsets.all(2):null,
      clipBehavior: Clip.none,
      child: InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed(
          AnimeDetails.routeName,
          arguments: recData.malId,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  recData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              recData.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Color.fromRGBO(200, 200, 200, 1),
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}