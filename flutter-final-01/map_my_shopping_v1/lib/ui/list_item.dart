import 'package:flutter/cupertino.dart';

class ShoppingItem extends StatelessWidget {
  const ShoppingItem(
      {super.key, this.itemName = "Error", this.price = -1, this.aisle = "00"});

  final String itemName;
  final double price;
  final String aisle;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(itemName),
        Text("Price: \$${price.toString()}"),
        Text("Aisle: $aisle")
      ],
    ));
  }
}
