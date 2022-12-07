import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';
import 'package:map_my_shopping_v1/app/map_logic.dart';
import 'package:faker/faker.dart';
import 'dart:math';

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  CustomDialog(BuildContext context, this.filter, this.searchResults,
      this.allResults, this.search,
      {super.key});

  List<String> filter;
  final List<ShopItem> allResults;
  List<ShopItem> searchResults;
  String search;

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
    loadbools();
  }

  List<String> filters = [];
  //bool canUpload = false;
  final List<String> _texts = getDepartments();
  final List<bool> _isChecked = [];

  void loadbools() async {
    for (int i = 0; i < _texts.length; i++) {
      _isChecked.add(false);
    }
  }

  void passFilters(List<String> updatedfilters) {
    updatedfilters = filters;
  }

  List<ShopItem> filterQuery(String term, List<String> filters) {
    List<ShopItem> results = [];

    var allResults = widget.allResults;
    for (int i = 0; i < allResults.length; ++i) {
      if (allResults[i].product.toLowerCase().contains(term.toLowerCase()) ||
              allResults[i].department.toLowerCase().contains(term
                  .toLowerCase()) /*||
          allResults[i]
              .description
              .toLowerCase()
              .contains(term.toLowerCase())*/
          ) {
        results.add(allResults[i]);
      }
    } //allResults;

    const thingy = 'ABCDEFGHIJ';
    List<String> deps = filters.isNotEmpty ? filters : getDepartments();
    Random rnd = Random();

    for (int i = 0; i < 4; ++i) {
      String name = "$term item number + $i";
      String desc = "example of additional search results";
      double price = rnd.nextDouble() * 100;
      String aisle = thingy[faker.randomGenerator.integer(thingy.length)] +
          faker.randomGenerator.integer(30).toString();

      String dep = deps[rnd.nextInt(deps.length)];

      results.add(ShopItem(name, desc, price, aisle, dep));
    }

    /*for (int i = 0; i < results.length; ++i) {
      print(results[i].product);
      print(results[i].department);
    }*/

    if (filters.isNotEmpty) {
      for (int i = 0; i < results.length; i += 1) {
        String dep = results[i].department;
        //print(dep);
        //print(results[i].product);
        //print(filters.contains(dep));
        if (filters.contains(dep) == false) {
          results.remove(results[i]);
          i -= 1;
        }
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //scrollable: true,
      title: const Text('Filters'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _texts.length,
                      itemBuilder: (_, index) {
                        return CheckboxListTile(
                          title: Text(_texts[index]),
                          value: _isChecked[index],
                          onChanged: (bool? val) {
                            setState(() {
                              _isChecked[index] = val!;
                              //print(filters);
                              if (filters.contains(_texts[index]) == true) {
                                filters.remove(_texts[index]);
                                //print(filters);
                              } else {
                                filters.add(_texts[index]);
                                //print(filters);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),

      actions: <Widget>[
        SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                setState(() {
                  widget.filter = filters;
                  //print(widget.filter);
                  widget.searchResults = filterQuery(widget.search, filters);
                  //print(widget.searchResults);

                  //SearchPage();
                });
                Navigator.of(context).pop(widget.filter);
                // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => SearchPage())
                //Navigator.popAndPushNamed(context, routes[index]);
              },
              child: const Text('Apply'),
            )),
        SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                // setState(() {
                //   widget.filter = filters;
                //   print(widget.filter);
                //   widget.searchResults = FilterQuery(widget.search, filters);
                //   print(widget.searchResults);
                //   //SearchPage();
                // });
                Navigator.of(context).pop();
                // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => SearchPage())
                //Navigator.popAndPushNamed(context, routes[index]);
              },
              child: const Text('Close'),
            ))
      ],
    );
  }
}
