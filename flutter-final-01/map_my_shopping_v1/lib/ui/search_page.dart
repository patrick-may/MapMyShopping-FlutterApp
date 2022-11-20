import "package:flutter/material.dart";
import "package:faker/faker.dart";
import "package:map_my_shopping_v1/ui/nav_bar.dart";
import "package:map_my_shopping_v1/ui/list_item.dart";
import "dart:developer";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.navState = 3});

  final int navState;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _currentlySearching = false;
  String searchValue = "";
  List<ShoppingItem> _items = [ShoppingItem(itemName: "Default Item")];
  Widget _scrollResults = ScrollResults(query: "default");

  Widget _searchField() {
    return TextField(
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: const InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
      onSubmitted: (String s) {
        setState(() {
          log("data submitted, with query $s");

          _scrollResults = ScrollResults(query: s);
          _currentlySearching = false;
        });
      },
    );
  }

  Widget _defaultList() {
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(child: ListTile(title: _items[0]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Search Page",
      home: Scaffold(
        appBar: AppBar(
            title: !_currentlySearching
                ? const Text("Map My Shopping Search Page")
                : _searchField(),
            actions: !_currentlySearching
                ? [
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _currentlySearching = true;
                          });
                        })
                  ]
                : [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _currentlySearching = false;
                          });
                        },
                        icon: const Icon(Icons.clear))
                  ]),
        body: _scrollResults,
        bottomNavigationBar: const TopLevelNavBar(
          navState: 3,
        ),
      ),
    );
  }
}

class ScrollResults extends StatefulWidget {
  ScrollResults({super.key, required this.query});
  String query;

  @override
  State<ScrollResults> createState() => _ScrollResultsState();
}

class _ScrollResultsState extends State<ScrollResults> {
  final _results = <ShoppingItem>[];
  //final _styling = const TextStyle(fontSize: 18);
  void refresh(String newQuery) {
    setState(() {
      widget.query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _results.length) {
          for (int a = 0; a < 10; ++a) {
            var name = "${widget.query} + $a";

            var locAisle = faker.randomGenerator
                    .fromCharSet("ABCDEFGHIJKLMNOPQRSTUVWXYZ", 2) +
                faker.randomGenerator.fromCharSet("1234567890", 2);

            var locPrice = faker.randomGenerator.decimal();
            _results.add(ShoppingItem(
              itemName: name,
              price: locPrice,
              aisle: locAisle,
            ));
          }
        }
        return _results[index];
      },
    );
  }
}
