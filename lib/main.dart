import 'package:mangamojo/services/api.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:mangamojo/views/anime_details.dart';
import 'package:mangamojo/views/home.dart';

void main() {
  runApp(const MyApp(key: Key('main')));
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       ChangeNotifierProvider(
          create: (context) => DataService(),

      child: MaterialApp(
        title: 'AnimSearch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color:Color.fromRGBO(31, 31, 31, 1),
            elevation: 0,
          ),
          // primaryColor:const Color.fromRGBO(254,200,72,1),
          primaryColor:const Color.fromRGBO(25, 25, 25, 1),
          primaryColorDark: const Color.fromRGBO(25, 25, 25, 1),
          primaryColorLight: const Color.fromRGBO(31, 31, 31, 1),
          secondaryHeaderColor:  const Color.fromRGBO(254,200,72,1),
        ),
        home: Home(),
        routes: {
          AnimeDetails.routeName: (context) => AnimeDetails(),
        },
      ),
    );
  }
}