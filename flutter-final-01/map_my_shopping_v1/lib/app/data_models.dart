import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

// IF YOU MAKE EDITS TO THIS PAGE, RERUN THE FOLLOWING:
// $> flutter packages pub run build_runner build
part 'data_models.g.dart';

@HiveType(typeId: 0)
class ShopItem extends HiveObject {
  @HiveField(0)
  late String product;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late double price;

  @HiveField(3)
  late String aisle;

  @HiveField(4)
  late String department;

  ShopItem(
      this.product, this.description, this.price, this.aisle, this.department);

  // "build" the shop item to a nice displayable thing. This is the template for all
  // shop items
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(product,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
            Text(
              "Price: \$${price.toStringAsFixed(2)}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            Text(
              "Aisle: $aisle",
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            )
          ],
        )));
  }
}
