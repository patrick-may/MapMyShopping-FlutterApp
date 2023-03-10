//declare packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';
import 'package:map_my_shopping_v1/app/map_logic.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';
import 'package:faker/faker.dart';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:map_my_shopping_v1/app/boxes.dart';
import 'package:csv/csv.dart';
import 'package:map_my_shopping_v1/app/dialog_widget.dart';

//this code was *heavily* inspired y some stack overflow answers

class SearchPage extends StatefulWidget {
  const SearchPage({super.key}) : super();

  @override
  SearchPageState createState() => SearchPageState();
}

//state of the widget
class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    loadResults();
  }

  late String searchterm = "";
  List<ShopItem> searchResults = [];

  late List<ShopItem> allResults;
  // first run this to read all the items in our DB...?

  void loadResults() async {
    String data = await rootBundle.loadString('assets/all_items.csv');
    List<List<dynamic>> itemSquare = const CsvToListConverter().convert(data);

    List<ShopItem> vals = [];
    // CSV IS OF FORMAT: product, description, price (must be valid double), Aisle, Department
    for (int i = 0; i < itemSquare.length; ++i) {
      //debugPrint(itemSquare[i].toString());
      vals.add(ShopItem(itemSquare[i][0], itemSquare[i][1],
          itemSquare[i][2].toDouble(), itemSquare[i][3], itemSquare[i][4]));
    }
    allResults = vals;
  }

  // given some String seach query, return the specific results we want
  // currently PURE random data, would be highly preferrable if pseudostructured
  List<ShopItem> searchQuery(String term) {
    List<ShopItem> results = [];

    for (int i = 0; i < allResults.length; ++i) {
      if (allResults[i].product.toLowerCase().contains(term.toLowerCase()) ||
          allResults[i]
              .description
              .toLowerCase()
              .contains(term.toLowerCase()) ||
          allResults[i].department.toLowerCase().contains(term.toLowerCase())) {
        results.add(allResults[i]);
      }
    } //allResults;

    const thingy = 'ABCDEFGHIJ';
    List<String> deps = getDepartments();
    Random rnd = Random();

    for (int i = 0; i < 4; ++i) {
      String name = "$term item number + $i";
      String desc = "example of additional search results";
      double price = rnd.nextDouble();
      String aisle = thingy[faker.randomGenerator.integer(thingy.length)] +
          faker.randomGenerator.integer(30).toString();
      String dep = deps[rnd.nextInt(deps.length)];
      results.add(ShopItem(name, desc, price, aisle, dep));
    }

    return results;
  }

  List<ShopItem> filterQuery(String term, List<String> filters) {
    List<ShopItem> results = [];

    for (int i = 0; i < allResults.length; ++i) {
      if (allResults[i].product.toLowerCase().contains(term.toLowerCase()) ||
          allResults[i].department.toLowerCase().contains(term.toLowerCase()) ||
          allResults[i].department.toLowerCase().contains(term.toLowerCase())) {
        results.add(allResults[i]);
      }
    } //allResults;

    const thingy = 'ABCDEFGHIJ';
    List<String> deps = getDepartments();
    Random rnd = Random();

    for (int i = 0; i < 4; ++i) {
      String name = "$term item number + $i";
      String desc = "example of additional search results";
      double price = rnd.nextDouble();
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

  List<String> filters = [];

  // Create/Write to the NoSQL DB (Man CS jargon really is pretentious)
  void addItem(ShopItem addme) {
    final deepCpy = ShopItem(addme.product, addme.description, addme.price,
        addme.aisle, addme.department);

    Hive.openBox<ShopItem>('shopping list');
    final box = Boxes.getShoppingList();
    try {
      box.add(deepCpy);
    } catch (hiveAddError) {
      // could do a pop-up here that item is already in the cart?
      debugPrint("Duplicate Add (impossible)");
    }
    // to control the key of the item, instead do
    // box.put('hashkey here', addme);
  }

  void displayAddedToList(ShopItem addme) {
    var bottomPop = SnackBar(content: Text("${addme.product} has been added"));
    ScaffoldMessenger.of(context).showSnackBar(bottomPop);
  }

  // container for ShopItem and a AddToList button
  // this is where DB linking happens
  Widget searchContainer(ShopItem display) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        display.build(context, 0.55),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            addItem(display);
            displayAddedToList(display);
            setState(() {
              searchResults.remove(display);
            });
          },

          // editing this child is what will change the USER INTERFACE
          child: Column(children: const [
            Icon(Icons.add),
            Text("Add"),
          ]),
        ),
        ElevatedButton(
            onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context, display),
                  ),
                },
            child: Column(children: const [Icon(Icons.info), Text("Info")]))
      ],
    );
  }

  //Popup box code that will display the info of the item
  //yoinked from Aymane's list page
  Widget _buildPopupDialog(BuildContext context, ShopItem display) {
    return AlertDialog(
      title: Text(display.product),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Description: ${display.description}\n",
            textAlign: TextAlign.left,
          ),
          Text(
            "Price: \$${display.price.toStringAsFixed(2)}",
            textAlign: TextAlign.left,
          ),
          Text(
            "Aisle: ${display.aisle}",
            textAlign: TextAlign.left,
          ),
          Text(
            "Department: ${display.department}",
            textAlign: TextAlign.left,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  List<ShopItem> filterSimple(List<String> filters) {
    List<ShopItem> results = [];

    for (int i = 0; i < allResults.length; ++i) {
      results.add(allResults[i]);
    } //allResults;

    if (filters.isNotEmpty) {
      for (int i = 0; i < results.length; i += 1) {
        String dep = results[i].department;
        if (filters.contains(dep) == false) {
          results.remove(results[i]);
          i -= 1;
        }
      }
    }
    return results;
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CustomDialog(context, filters, searchResults, allResults)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context);
    const SearchPage();
    setState(() {
      filters = result;
      searchResults = filterQuery(searchterm, filters);
      const SearchPage();
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Search',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          //Search Bar to List of typed Subject
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.all(15.0),
                hintText: 'Search ',
              ),
              onSubmitted: (String str) {
                {
                  // filter stuffs
                  setState(() {
                    //debugPrint("Search Submitted $str");
                    searchterm = str;
                    searchResults = filterQuery(str, filters);
                  });
                }
              },
            ),
          ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(50, 40), // size of the filters button
                  ),
                  onPressed: () => {
                        // showDialog(context: context,
                        // builder: (BuildContext context) => CustomDialog(context, filters, searchResults, allResults, searchterm)),
                        _navigateAndDisplaySelection(context),
                      },
                  child: Column(
                      children: const [Icon(Icons.filter_list), Text("Filters")])),
           Text(
             "Filters Selected: ${filters.toList()}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          // List of all the results :D
          Expanded(
            child: searchResults.isEmpty
                // EDIT ME FOR THE TEXT BEFORE SEARCHING :)
                ? const Text(
                    "Search Item to Begin",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              searchContainer(searchResults[index])
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const TopLevelNavBar(navState: 3),
    );
  }
}


// HERE LIES A GRAVEYARD OF API-INTERACTIVE CODE :_(
/*

//parse the agents from the api

  static List<Subject> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  }


//Declare Subject class for json data or parameters of json string/data
//Class For Subject

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    return Subject(
      text: json['text'],
      author: json['author'],
    );
  }
//String url = 'https://type.fit/api/quotes';

  Future<List<Subject>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<Subject> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//final _debouncer = Debouncer();

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
*/
