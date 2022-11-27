import 'data_models.dart';

// OBJECTIVE:
// given a List<ShopItem>, return the ORDER in which best to display the items.
// Then attempt to dynamically create a navigation graphic for each given "step" of the process

List<ShopItem> bestRoute(List<ShopItem> shoppingList) {
  //simple sort based on alphabetical aisle number (change me later)
  shoppingList.sort(((a, b) => a.aisle[0].compareTo(b.aisle[0])));
  return shoppingList;
}

// M rows by N columns
// N ~= 125 Steps per row
// M ~= 80 rows
// 125 * 80 = 10 000... brb, going to python script this shrizzler
// going to come back to this last..... (I cry everytime)
List<List<String>> woosterStoreMap() {
  List<List<String>> map = [[]];

  return map;
}

List<String> getDepartments() {
  return [
    "Sporting Goods",
    "Toys",
    "Electronics",
    "Paint",
    "Hardware",
    "Auto",
    "Clearance",
    "Garden",
    "Storage & Laundry",
    "Bath",
    "Bedding",
    "Home",
    "Cosmetics",
    "Furniture",
    "Health",
    "Kitchen & Dining",
    "Home Office",
    "Crafts",
    "Celebrate",
    "Seasonal",
    "Clothing: Girls",
    "Clothing: Boys",
    "Clothing: Baby",
    "Clothing: Sleepwear & Panties",
    "Clothing: Ladies",
    "Clothing: Mens",
    "Jewelry & Accessories",
    "Fresh Produce",
    "Bakery",
    "Meat",
    "Deli",
    "Snacks",
    "Frozen",
    "Grocery",
    "Adult Beverages",
    "Dairy",
    "Household Paper",
    "Cleaning",
    "Pet",
    "Shoes",
    "Checkout"
  ];
}
