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
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text(itemName,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Price: \$${price.toStringAsFixed(2)}",
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Aisle: $aisle",
                  textAlign: TextAlign.left,
                )
              ],
            )
          ],
        ));
  }
}
