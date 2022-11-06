import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title = "default", this.navState = 0})
      : super(key: key);

  final String title;
  final int navState;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("home screen hrmmm"),
      ),
      bottomNavigationBar: const TopLevelNavBar(
        navState: 0,
      ),
    );
  }
}
