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

  Future<void> getData(String category) async {
    await Provider.of<DataService>(context, listen: false)
        .getHomeData(category: category);
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
            height:30,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
            decoration: BoxDecoration(
              color: _selectedIndex == myIndex
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:Theme.of(context).secondaryHeaderColor,
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
                    : const Color.fromRGBO(220, 220, 220, 1)
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchAppBar(
        color: Theme.of(context).primaryColorLight,
        liftOnScrollElevation: 0,
        shadowColor: Colors.red,
        hideKeyboardOnDownScroll: true,
        title: Container(),
        hint: 'Search anime or manga',
        iconColor: Color.fromRGBO(220, 220, 220, 1),
        autocorrect: false,
        hintStyle: TextStyle(
          color: Color.fromRGBO(100,100, 100, 1)
        ),
        titleStyle: TextStyle(
            color: Color.fromRGBO(220,220, 220, 1)
        ),

        onFocusChanged: (isFocused) {
          if (!isFocused) {
            setState(() {
              searching = false;
              getData('top');
            });
          }
        },
        leadingActions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                icon: Icon(Icons.home,
                    color: Color.fromRGBO(220, 220, 220, 1)),
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    getData('airing');
                  });
                }),
          ),
          //
        ],
        onSubmitted: (query) {
          setState(() {
            _selectedIndex = 0;
            searching = true;
            searchData(query);
          });
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
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
            Expanded(
              child: AnimeGrid(),
            ),
          ],
        ),
      ),
    );
  }
}