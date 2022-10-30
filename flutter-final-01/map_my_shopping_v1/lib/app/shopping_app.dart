import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/home_page.dart';

class MapMyShoppingApp extends StatelessWidget {
  const MapMyShoppingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map My Shopping Babeeee!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
