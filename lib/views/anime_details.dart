import 'package:flutter/foundation.dart';
import 'package:mangamojo/models/anime.dart';
import 'package:mangamojo/services/api.dart';
import 'package:mangamojo/widgets/genre_details.dart';
import 'package:mangamojo/widgets/anime_header.dart';
import 'package:mangamojo/widgets/rec_card.dart';
import 'package:mangamojo/widgets/webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeDetails extends StatefulWidget {
  static const routeName = '/animedetailscreen';

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetails> {
  var _isInit = true;
  var showRecommendation=true;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      late int animeId = ModalRoute.of(context)!.settings.arguments as int;
      Provider.of<DataService>(context, listen: false).getAnimeData(animeId);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataService>(context);
    const isWeb = kIsWeb;
    final Anime animeData = dataProvider.animeData;
    if(dataProvider.recommendationList.isEmpty){
      showRecommendation=false;
    }
    final device = MediaQuery.of(context);
    final screenHeight = device.size.height;
    final screenWidth = device.size.width;
    final isNotMobile = screenWidth>600;
    return Scaffold(
      floatingActionButton: isWeb?null:!dataProvider.isLoading
          ? FloatingActionButton(
        tooltip: 'Open in browser',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewContainer(animeData.url),
            ),
          );
        },
        child: const Icon(
          Icons.open_in_browser_outlined,
          color: Colors.white,
        ),
      )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(builder:(BuildContext context,BoxConstraints constraints){
        if(constraints.maxWidth<600){
          return !dataProvider.isLoading
              ? Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height:kIsWeb?screenHeight:screenWidth / 1.3,
                width: screenWidth,
                color: const Color.fromRGBO(255, 222, 89, 1),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.multiply),
                  child: Hero(
                    tag: animeData.malId,
                    child: Image.network(
                      animeData.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: screenWidth / 1.5),
                clipBehavior: Clip.none,
                child: Container(
                  width: screenWidth,
                  padding:const EdgeInsets.only(bottom:25),
                  decoration:  BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25)
                            .copyWith(top: 25),
                        child: AnimeHeader(
                          animeData: animeData,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25)
                            .copyWith(top: 25),
                        child: Text(
                          animeData.synopsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            color:Color.fromRGBO(120, 120, 120, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: GenreDetails(animeData: animeData,context:context),
                      ),
                      showRecommendation==true? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Animes Like This',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color:Color.fromRGBO(220, 220, 220, 1),
                          ),
                        ),
                      ):Container(),
                      showRecommendation==true?Container(
                        height: isNotMobile?300:screenWidth / 2,
                        width: screenWidth,
                        margin: const EdgeInsets.symmetric(vertical: 15)
                            .copyWith(bottom: 35),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.recommendationList.length,
                          itemBuilder: (context, index) => RecommendationCard(
                            recData: dataProvider.recommendationList[index],
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              ),
            ],
          )
              :  Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).secondaryHeaderColor,
                strokeWidth: 5,
              ));
        }else{
          return Container();
        }

      })
    );
  }
}