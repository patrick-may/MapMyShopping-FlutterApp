import "package:flutter/material.dart";
//import "package:map_my_shopping_v1/app/shopping_app.dart";
//import "package:map_my_shopping_v1/ui/account_page.dart";
import "package:map_my_shopping_v1/ui/home_page.dart";
import "package:map_my_shopping_v1/ui/search_page.dart";

class TopLevelNavBar extends StatefulWidget {
  const TopLevelNavBar({super.key});

  @override
  State<TopLevelNavBar> createState() => _TopLevelNavBarState();
}

class _TopLevelNavBarState extends State<TopLevelNavBar> {
  int _selectedIndex = 0;
  //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  /*static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Lists',
      style: optionStyle,
    ),
    Text(
      'Index 2: Map',
      style: optionStyle,
    ),
    Text(
      'Index 3: Search',
      style: optionStyle,
    ),
  ];*/
  var routes = {
    '/home': const HomePage(title: "Map My Shopping :)"),
    '/search_page': const SearchPage()
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      var routeNames = [
        const HomePage(title: "Map My Shopping :)"),
        const HomePage(title: "Map My Shopping :)"),
        const SearchPage(),
        const SearchPage()
      ];
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => routeNames[index]));
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
