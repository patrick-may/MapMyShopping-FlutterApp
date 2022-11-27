import 'package:flutter/material.dart';
import 'package:map_my_shopping_v1/app/data_models.dart';
import 'package:map_my_shopping_v1/app/shopping_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // boilerplate stuff

  await Hive.initFlutter(); // make certain our DBs loaded

  Hive.registerAdapter(ShopItemAdapter()); //register adapter to our datamodel
  await Hive.openBox<ShopItem>(
      'shopping list'); // make box for the shopping list

  runApp(const MapMyShoppingApp()); //do the thingy
}
