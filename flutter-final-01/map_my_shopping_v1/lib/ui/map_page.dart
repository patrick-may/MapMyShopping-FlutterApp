import "package:flutter/material.dart";
import "package:map_my_shopping_v1/ui/nav_bar.dart";

class MapPage extends StatefulWidget {
  const MapPage({super.key, this.navState = 2});

  final int navState;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Router"),
        centerTitle: true,
      ),
      bottomNavigationBar: const TopLevelNavBar(navState: 2),
    );
  }
}
