import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';
import 'dart:developer';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // container for each entry in the list display
  Widget listContainer(ShopItem display) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        display.build(context),
        ElevatedButton(
            onPressed: () => {
                  log("Remove Pressed")
                  /* remove from db */
                },
            child: const Text("Remove")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
