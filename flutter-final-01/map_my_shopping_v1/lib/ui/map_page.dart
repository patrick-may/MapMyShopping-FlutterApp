import "package:flutter/material.dart";
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
  @override
  void initState() {
    var box = Boxes.getShoppingList();
    items = box.values.toList().cast<ShopItem>();
    super.initState();
  }

  Widget choiceScreen(items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Current List:"),
        Container(
          decoration: BoxDecoration(border: Border.all(), color: Colors.blue),
          height: MediaQuery.of(context).size.height * 0.4,
          child: displayList(items),
        ),
        RichText(
            text: const TextSpan(
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                children: <TextSpan>[
              TextSpan(text: "Store Associated with List:"),
              TextSpan(
                  text: "Wooster Walmart",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ])),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.075)),
          onPressed: () => {
            // push the active map routing page
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
            "Description: ${display.description}",
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
      body: choiceScreen(items),
      bottomNavigationBar: const TopLevelNavBar(navState: 2),
    );
  }
}
