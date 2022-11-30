//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';
import 'help_page.dart';

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
    /*buildImg(double height, String text) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Icon Instruct.JPG'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ));
    }*/

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/MapMyShopping Logo.png'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Welcome to MapMyShopping",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                child: const Text("Getting Started"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HelpPage()));
                  ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 100),
                      backgroundColor: Colors.purple);
                })
          ]),
      bottomNavigationBar: const TopLevelNavBar(
        navState: 0,
      ),
    );
  }
}
