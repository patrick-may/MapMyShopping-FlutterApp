import 'dart:html';

import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title = "default", this.navState = 0})
      : super(key: key);

  final String title;
  final int navState;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(100),
              child: const Text("Welcome to MapMyShopping"),
            ),
            ElevatedButton(
                child: const Text("Getting Started"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                  ElevatedButton.styleFrom(
                      minimumSize: Size(100, 100),
                      backgroundColor: Colors.purple);
                })
          ]),
      bottomNavigationBar: const TopLevelNavBar(
        navState: 0,
      ),
    );
  }
}
