import "package:flutter/material.dart";
import "package:map_my_shopping_v1/ui/home_page.dart";
import 'package:map_my_shopping_v1/ui/map_page.dart';
import "package:map_my_shopping_v1/ui/search_page.dart";
import "package:map_my_shopping_v1/ui/lists_page.dart";

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
        const HomePage(title: "Map My Shopping"),
        const ListPage(),
        const MapPage(),
        const SearchPage()
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
