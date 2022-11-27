import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:map_my_shopping_v1/ui/nav_bar.dart';
import 'package:map_my_shopping_v1/app/boxes.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // container for each entry in the list display

  void removeItem(ShopItem delme) async {
    await Hive.openBox<ShopItem>(
        'shopping list'); //redundant opens because hive is **** (who picked that dependency? (it was me))
    final box = Boxes.getShoppingList();
    box.delete(delme.key);
  }

  Widget listContainer(ShopItem display) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        display.build(context),
        ElevatedButton(
          onPressed: () => {log("Remove Pressed"), removeItem(display)},
          child: Column(children: const [
            Icon(Icons.remove_shopping_cart_rounded),
            Text("Remove")
          ]),
        ),
        ElevatedButton(
          onPressed: () => {showDialog(context: context, builder: (BuildContext context) => _buildPopupDialog(context, display),)},
          child: Column(children: const [
            Icon(Icons.info),
            Text("Info")
          ]),
        )
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

  //UI for the ENTIRE list page :D
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current List"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<ShopItem>>(
          valueListenable: Boxes.getShoppingList().listenable(),
          builder: (context, box, _) {
            final items = box.values.toList().cast<ShopItem>();

            return displayList(items);
          }),
      bottomNavigationBar: const TopLevelNavBar(navState: 1),
    );
  }
}
