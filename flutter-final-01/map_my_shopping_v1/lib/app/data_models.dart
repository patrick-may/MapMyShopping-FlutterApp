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
}
