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

  List<ShopItem> searchResults = [];

  late List<ShopItem> allResults;
  // first run this to read all the items in our DB...?

  void loadResults() async {
    String data = await rootBundle.loadString('assets/all_items.csv');
    List<List<dynamic>> itemSqaure = const CsvToListConverter().convert(data);

    List<ShopItem> vals = [];
    // CSV IS OF FORMAT: product, description, price (must be valid double), Aisle, Department
    for (int i = 0; i < itemSqaure.length; ++i) {
      vals.add(ShopItem(itemSqaure[i][0], itemSqaure[i][1],
          itemSqaure[i][2].toDouble(), itemSqaure[i][3], itemSqaure[i][4]));
    }
    allResults = vals;
  }

  // given some String seach query, return the specific results we want
  // currently PURE random data, would be highly preferrable if pseudostructured
  List<ShopItem> searchQuery(String term) {
    List<ShopItem> results = allResults;

    const thingy = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    List<String> deps = getDepartments();
    Random rnd = Random();

    for (int i = 0; i < 10; ++i) {
      String name = "$term + $i";
      String desc = "default desc, unused atm";
      double price = rnd.nextDouble();
      String aisle = thingy[faker.randomGenerator.integer(26)] +
          faker.randomGenerator.integer(30).toString();
      String dep = deps[rnd.nextInt(deps.length)];
      results.add(ShopItem(name, desc, price, aisle, dep));
    }

    return results;
  }

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

  // container for ShopItem and a AddToList button
  // this is where DB linking happens
  Widget searchContainer(ShopItem display) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        display.build(context),
        ElevatedButton(
          onPressed: () {
            addItem(display);
          },

          // editing this child is what will change the USER INTERFACE
          child: Column(
              children: const [Icon(Icons.add_shopping_cart), Text("Add")]),
        )
      ],
    );
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Search',
          style: TextStyle(fontSize: 25),
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
                    searchResults = searchQuery(str);
                  });
                }
              },
            ),
          ),

          // List of all the results :D
          Expanded(
            child: searchResults.isEmpty
                // EDIT ME FOR THE TEXT BEFORE SEARCHING :)
                ? const Text(
                    "Search Something to Begin!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
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
