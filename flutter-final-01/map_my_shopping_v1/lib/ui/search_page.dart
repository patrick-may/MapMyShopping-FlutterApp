import "package:flutter/material.dart";
import "package:faker/faker.dart";
import "package:map_my_shopping_v1/ui/nav_bar.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "search page...?",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search Page :D"),
        ),
        body: const Center(
          child: ScrollResults(),
        ),
        bottomNavigationBar: const TopLevelNavBar(),
      ),
    );
  }
}

class ScrollResults extends StatefulWidget {
  const ScrollResults({super.key});

  @override
  State<ScrollResults> createState() => _ScrollResultsState();
}

class _ScrollResultsState extends State<ScrollResults> {
  final _results = <Text>[];
  final _styling = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _results.length) {
          for (int a = 0; a < 10; ++a) {
            _results.add(Text(faker.food.dish()));
          }
        }
        return _results[index];
      },
    );
  }
}
