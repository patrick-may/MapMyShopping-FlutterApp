import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title = "default"}) : super(key: key);

  final String title;

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
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, "/search_page"),
          child: const Text("home screen hrmmm"),
        ),
      ),
      bottomNavigationBar: const TopLevelNavBar(),
    );
  }
}
