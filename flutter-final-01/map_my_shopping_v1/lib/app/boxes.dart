import 'package:hive/hive.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';

class Boxes {
  static Box<ShopItem> getShoppingList() => Hive.box<ShopItem>('shopping list');
}
