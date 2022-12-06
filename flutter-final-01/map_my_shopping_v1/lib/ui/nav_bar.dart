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
        const HomePage(title: "Home Page"),
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
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                backgroundColor: const Color.fromARGB(255, 49, 24, 107),
                activeIcon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 49, 24, 107),
                  ),
                )),
            BottomNavigationBarItem(
                icon: const Icon(Icons.list_sharp),
                label: 'List',
                backgroundColor: const Color.fromARGB(255, 49, 24, 107),
                activeIcon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(
                    Icons.view_list_rounded,
                    color: Color.fromARGB(255, 49, 24, 107),
                  ),
                )),
            BottomNavigationBarItem(
                icon: const Icon(Icons.map_outlined),
                label: 'Map',
                backgroundColor: const Color.fromARGB(255, 49, 24, 107),
                activeIcon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(
                    Icons.map_outlined,
                    color: Color.fromARGB(255, 49, 24, 107),
                  ),
                )),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: 'Search',
                backgroundColor: const Color.fromARGB(255, 49, 24, 107),
                activeIcon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 49, 24, 107),
                  ),
                )),
          ],
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: const Color.fromARGB(255, 139, 136, 136),
          selectedFontSize: 15,
          unselectedFontSize: 13,
          onTap: _onItemTapped,
        ));
  }
}
