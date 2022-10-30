import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/home_page.dart';
import 'package:map_my_shopping_v1/ui/search_page.dart';

class MapMyShoppingApp extends StatelessWidget {
  const MapMyShoppingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // route maker!
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(title: "Map My Shopping :)"),
        '/search_page': (context) => const SearchPage()
      },

      title: 'Map My Shopping Babeeee!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'default title'),
    );
  }
}
