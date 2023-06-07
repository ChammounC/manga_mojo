import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mangamojo/services/api.dart';
import 'package:mangamojo/views/anime_grid.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;
  bool searching = false;
  bool searchBarFocused = false;
  int globalPage = 0;

  final categoryList = [
    'airing',
    'bypopularity',
    'upcoming',
    'movie',
    'favorite',
  ];

  Future<void> getData(String category, {int page = 1}) async {
    await Provider.of<DataService>(context, listen: false)
        .getHomeData(category: category, page: globalPage);
  }

  void searchData(String query) {
    Provider.of<DataService>(context, listen: false).searchData(query);
  }

  Widget _buttonBuilder(String name, int myIndex, String category) {
    return Visibility(
      maintainState: true,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = myIndex;
            getData(category);
          });
        },
        child: FittedBox(
          child: Container(
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
            decoration: BoxDecoration(
              color: _selectedIndex == myIndex
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).secondaryHeaderColor,
                width: .8,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _selectedIndex == myIndex
                      ? Colors.white
                      : const Color.fromRGBO(220, 220, 220, 1)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final screenWidth = device.size.width;
    final screenHeight = device.size.height;
    final isLargeTab = screenWidth < 1201 && screenWidth > 1000;
    final isTab = screenWidth < 1001 && screenWidth > 699;
    final isMobile = screenWidth < 700;
    globalPage = Provider.of<DataService>(context).homePage;
    return Scaffold(
      body: FloatingSearchAppBar(
        color: Theme.of(context).primaryColorLight,
        liftOnScrollElevation: 0,
        shadowColor: Colors.red,
        hideKeyboardOnDownScroll: true,
        automaticallyImplyBackButton: false,
        title: Container(),
        hint: 'Search anime or manga',
        iconColor: Color.fromRGBO(220, 220, 220, 1),
        autocorrect: false,
        hintStyle: TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
        titleStyle: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),
        onFocusChanged: (isFocused) {
          if (isFocused) {
            setState(() {
              searchBarFocused = true;
            });
          }
          if (!isFocused) {
            setState(() {
              searching = false;
              searchBarFocused = false;
              // getData('top');
            });
          }
        },
        leadingActions: [
          Padding(
              padding: searchBarFocused
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () => {
                  setState(() {
                    _selectedIndex = 0;
                    globalPage = 1;
                    Provider.of<DataService>(context, listen: false).homePage =
                        1;
                    getData('airing', page: 1);
                  }),
                },
                child: Image.asset(
                    scale: 10,
                    searchBarFocused
                        ? 'assets/icon/logo.png'
                        : 'assets/icon/textLogo.png'),
              )),
          //
        ],
        onSubmitted: (query) {
          setState(() {
            _selectedIndex = 0;
            searching = true;
            searchData(query);
          });
        },
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).primaryColorLight,
                child: Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
                        width: screenWidth,
                        color: Theme.of(context).primaryColorLight,
                        child: Visibility(
                          maintainState: true,
                          visible: !searching,
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buttonBuilder('Top', 0, 'airing'),
                                _buttonBuilder('Popular', 1, 'bypopularity'),
                                _buttonBuilder('Upcoming', 2, 'upcoming'),
                                _buttonBuilder('Movies', 3, 'movie'),
                                _buttonBuilder('Favorite', 4, 'favorite'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    isMobile
                        ? Container()
                        : Flexible(
                            flex: isLargeTab
                                ? 3
                                : isTab
                                    ? 1
                                    : 3,
                            child: Container(
                                width: screenWidth,
                                height: 30,
                                color: Theme.of(context).primaryColorLight,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: globalPage <= 1
                                            ? null
                                            : () async{
                                          setState((){
                                                  globalPage--;
                                                  Provider.of<DataService>(
                                                          context,
                                                          listen: false)
                                                      .homePage--;
                                                  getData(
                                                      categoryList[
                                                          _selectedIndex],
                                                      page: globalPage);
                                                });
                                              },
                                        child: SizedBox(
                                            width: 50,
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color: globalPage <= 1
                                                  ? Colors.grey
                                                  : Theme.of(context)
                                                      .secondaryHeaderColor,
                                            ))),
                                    Text(
                                        Provider.of<DataService>(context,
                                                listen: true)
                                            .homePage
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,fontSize: 16)),
                                    InkWell(
                                      onTap: ()async{
                                        setState(() {
                                        globalPage++;
                                        Provider.of<DataService>(context,
                                                listen: false)
                                            .homePage++;
                                        getData(categoryList[_selectedIndex],
                                            page: globalPage);

                                        });
                                      },
                                      child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          )),
                                    ),
                                  ],
                                ))),
                  ],
                ),
              ),
              constraints.maxWidth > 900
                  ? Expanded(
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 7,
                          child: AnimeGrid(),
                        ),
                        Flexible(
                          flex: isTab ? 3 : 2,
                          child:
                              Container(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ))
                  : constraints.maxWidth < 901 && constraints.maxWidth > 700
                      ? Expanded(child: AnimeGrid())
                      : Expanded(
                          child: Column(
                          children: [
                            Flexible(flex: 12, child: AnimeGrid()),
                            Flexible(
                                flex: 1,
                                child: Container(
                                    width: screenWidth,
                                    color: Theme.of(context).primaryColorLight,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: globalPage <= 1
                                                  ? null
                                                  : () async  {
                                              setState((){
                                              globalPage--;
                                              Provider.of<DataService>(
                                              context,
                                              listen: false)
                                                  .homePage--;
                                              getData(
                                              categoryList[
                                              _selectedIndex],
                                              page: globalPage);
                                              });
                                                      },
                                              child: SizedBox(
                                                  width: 50,
                                                  child: Icon(
                                                    Icons.keyboard_arrow_left,
                                                    color: globalPage <= 1
                                                        ? Colors.grey
                                                        : Theme.of(context)
                                                            .secondaryHeaderColor,
                                                  ))),
                                          Text(
                                              Provider.of<DataService>(context,
                                                      listen: true)
                                                  .homePage
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                  fontSize: 20)),
                                          InkWell(
                                            onTap: () async {
                                              setState(() {
                                              globalPage++;
                                              Provider.of<DataService>(context,
                                                      listen: false)
                                                  .homePage++;
                                              getData(
                                                  categoryList[_selectedIndex],
                                                  page: globalPage);

                                              });
                                            },
                                            child: SizedBox(
                                                width: 50,
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ))),
                          ],
                        ))
            ],
          );
        }),
      ),
    );
  }
}
