import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';
import 'package:expandable/expandable.dart';
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
            const Text("Welcome to MapMyShopping"),
            ElevatedButton(
                child: const Text("Getting Started"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                })
          ]),
      bottomNavigationBar: const TopLevelNavBar(
        navState: 0,
      ),
    );
  }
}
