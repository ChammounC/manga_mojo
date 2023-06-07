import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mangamojo/services/api.dart';
import 'package:mangamojo/widgets/anime_card.dart';
import './error_screen.dart';

class AnimeGrid extends StatefulWidget {
  @override
  _AnimeGridPageState createState() => _AnimeGridPageState();
}

class _AnimeGridPageState extends State<AnimeGrid> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Provider.of<DataService>(context, listen: false).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final screenHeight = device.size.height;
    final screenWidth = device.size.width;
    final isTab = screenWidth < 1201 && screenWidth > 600;
    final isMobile = screenWidth < 601;
    final homeData = Provider.of<DataService>(context);
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraints){
        return Stack(
          children: [

            Image.asset(
              constraints.maxWidth>600?"assets/images/web_bg.jpeg":"assets/images/mobile_bg.jpg",
              height: screenHeight,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            Scaffold(
              // backgroundColor: Theme.of(context).primaryColorDark,
              backgroundColor: Colors.transparent,
              body: homeData.isError
                  ? ErrorScreen(homeData.errorMessage)
                  : homeData.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 222, 89, 1),
                  strokeWidth: 5,
                ),
              )
                  : RefreshIndicator(
                onRefresh: getData,
                color: const Color.fromRGBO(255, 222, 89, 1),
                strokeWidth: 2.5,
                child: LiveGrid.options(
                  padding: const EdgeInsets.all(15)
                      .copyWith(left: 20, right: 20),
                  options: const LiveOptions(
                    showItemInterval: Duration(
                      milliseconds: 100,
                    ),
                  ),
                  itemCount: homeData.searchList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile
                        ? 2
                        : isTab
                        ? 4
                        : 6,
                    childAspectRatio: 1.5 / 2.5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index, animation) =>
                      FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: AnimeCard(
                            homeData: homeData.searchList[index],
                            cardIndex: index,
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ],
        );
      },

    );
  }
}
