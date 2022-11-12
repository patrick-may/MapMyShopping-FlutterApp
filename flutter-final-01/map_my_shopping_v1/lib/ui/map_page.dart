import "package:flutter/material.dart";
import "package:map_my_shopping_v1/ui/nav_bar.dart";

class MapPage extends StatefulWidget {
  const MapPage({super.key, this.navState = 2});

  final int navState;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final int _navState = widget.navState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Page!"),
      ),
      bottomNavigationBar: TopLevelNavBar(navState: _navState),
    );
  }
}
