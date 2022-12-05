import "package:flutter/material.dart";
import 'package:map_my_shopping_v1/app/map_logic.dart';
import 'package:map_my_shopping_v1/ui/home_page.dart';
import "package:map_my_shopping_v1/ui/nav_bar.dart";
import "package:map_my_shopping_v1/app/data_models.dart";
import "package:map_my_shopping_v1/app/boxes.dart";

class MapPage extends StatefulWidget {
  const MapPage({super.key, this.navState = 2});

  final int navState;
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<ShopItem> items = [];
  bool navigating = false;
  @override
  void initState() {
    var box = Boxes.getShoppingList();
    items = box.values.toList().cast<ShopItem>();
    super.initState();
  }

  Widget routingScreen(items) {
    var pair = bestRoute(items); // do some magic to get the best stuff
    // unpack thingies
    List<ShopItem> orderedList = pair[0];
    List<String> directions = pair[1];
    int diridx = 0;
    // ImageType routeImg = pair[2]; // would be the spot to dynamically highlight the route

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: const Image(
                image: AssetImage("assets/Walmart 1814 Static Map.PNG"))),
        const Text(
          "Next Item:",
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
        ),
        Container(
            alignment: Alignment.center,
            //height: MediaQuery.of(context).size.height * 0.2,
            //width: MediaQuery.of(context).size.width,
            child: orderedList.isNotEmpty
                ? listContainer(orderedList[0])
                : listContainer(ShopItem(
                    "Shopping Complete!",
                    "You're all done... no secrets to find here",
                    -3.14,
                    "00",
                    "home"))),
        const Text(
          "Next Direction:",
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
        ),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: orderedList.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Text(
                          directions[1],
                          overflow: TextOverflow.fade,
                        ),
                        Checkbox(
                            value: false,
                            onChanged: (bool? newValue) {
                              setState(() {
                                debugPrint(directions.toString());
                                debugPrint(orderedList.toString());
                                orderedList.removeAt(0);
                                String rm = directions.removeAt(0);
                                debugPrint(rm);
                              });
                            })
                      ])
                : ElevatedButton(
                    onPressed: () {
                      //remove all items from db
                      //return to home page
                      // pop up "Route Complete!"
                      Boxes.getShoppingList().clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(title: "Home Page")));
                    },
                    child: const Text("Complete Trip")))
      ],
    );
  }

  Widget choiceScreen(items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Current List:", style: TextStyle(fontSize: 25)),
        RichText(
            text: const TextSpan(
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                children: <TextSpan>[
              TextSpan(
                text: "Store Associated with List:",
                style: TextStyle(fontSize: 20),
              ),
              TextSpan(
                  text: "Wooster Walmart",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ])),
        Container(
          decoration: BoxDecoration(border: Border.all(), color: Colors.blue),
          height: MediaQuery.of(context).size.height * 0.4,
          child: displayList(items),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.075)),
          onPressed: () => {
            setState(
                () => navigating = true), // push the active map routing page
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.navigation_rounded),
              Align(
                  alignment: Alignment.center,
                  child: Text("Map My Shopping!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0)))
            ],
          ),
        ),
      ],
    );
  }

  Widget listContainer(ShopItem display) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        display.build(context, 0.73),
        ElevatedButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, display),
            )
          },
          child: Column(children: const [Icon(Icons.info), Text("Info")]),
        )
      ],
    );
  }

  //Popup box code that will display the info of the item
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

  Widget displayList(items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(5),
      itemCount: items.length,
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
                listContainer(items[index]),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Router"),
        centerTitle: true,
      ),
      body: navigating ? routingScreen(items) : choiceScreen(items),
      bottomNavigationBar: const TopLevelNavBar(navState: 2),
    );
  }
}
