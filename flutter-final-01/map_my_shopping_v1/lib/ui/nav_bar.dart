import "package:flutter/material.dart";
import "package:map_my_shopping_v1/ui/home_page.dart";
<<<<<<< HEAD
import 'package:map_my_shopping_v1/ui/map_page.dart';
import "package:map_my_shopping_v1/ui/search_page.dart";
import "package:map_my_shopping_v1/ui/list_item.dart";
=======
//import "package:map_my_shopping_v1/ui/search_page.dart";
import "package:map_my_shopping_v1/ui/map_page.dart";
import "search_page_v2.dart";
>>>>>>> dd694317c960bd8644cce9a4c3407a836388cd07

class TopLevelNavBar extends StatefulWidget {
  const TopLevelNavBar({super.key, required this.navState});

  final int navState;

  @override
  State<TopLevelNavBar> createState() => _TopLevelNavBarState();
}

class _TopLevelNavBarState extends State<TopLevelNavBar> {
  late int _selectedIndex = widget.navState;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      var routeNames = [
<<<<<<< HEAD
        const HomePage(title: "Map My Shopping :)"),
        const ShoppingItem(),
        const MapPage(),
        const SearchPage()
=======
        const HomePage(title: "Home Page"),
        const HomePage(title: "Replace me with list page pls"),
        const MapPage(),
        const SearchItems()
>>>>>>> dd694317c960bd8644cce9a4c3407a836388cd07
      ];
      //Navigator.pop(context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => routeNames[index]));
      //Navigator.popAndPushNamed(context, routes[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromARGB(255, 49, 24, 107),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'Lists',
          backgroundColor: Color.fromARGB(255, 49, 24, 107),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Map',
          backgroundColor: Color.fromARGB(255, 49, 24, 107),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color.fromARGB(255, 49, 24, 107),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 165, 165, 165),
      onTap: _onItemTapped,
    );
  }
}
