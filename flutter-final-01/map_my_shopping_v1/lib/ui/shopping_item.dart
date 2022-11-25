import 'package:hive/hive.dart';

//part 'shopping.item.g.dart';

@HiveType(typeId: 1)
class ShoppingItem{
  @HiveField(0)
  String name;
  @HiveField(1)
  String aile;
  @HiveField(2)
  double price;
  @HiveField(3)
  String department;
  ShoppingItem(this.name, this.aile, this.price, this.department);
}
