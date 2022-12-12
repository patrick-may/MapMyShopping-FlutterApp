import 'data_models.dart';

// OBJECTIVE:
// given a List<ShopItem>, return the ORDER in which best to display the items.
// Then attempt to dynamically create a navigation graphic for each given "step" of the process
// in the future, could be edited to also create the image specific image desired

// RETURNS:
// LIST of two items:
//    List<ShopItems> shoppingList ordered in the best decided shopping route
//    List<String> dirs, each line a direction to an its corresponding item in shoppingList
List bestRoute(List<ShopItem> shoppingList) {
  //simple sort based on alphabetical aisle number (change me later)
  shoppingList.sort(((a, b) => a.aisle[0].compareTo(b.aisle[0])));

  // super bizarre bug on removeAt 0 for dirs... guh
  List<String> dirs = [];
  for (int i = 0; i < shoppingList.length; ++i) {
    dirs.add("Head to Aisle ${shoppingList[i].aisle}");
  }
  dirs.add("Head to Checkout");

  return [shoppingList, dirs];
}

// M rows by N columns
// N ~= 125 Steps per row
// M ~= 80 rows
// 125 * 80 = 10 000... brb, going to python script this shrizzler
// going to come back to this last..... (I cry everytime)
List<List<String>> woosterStoreMap() {
  List<List<String>> map = [[]];
  /*List<List<String>> deptMap = [
    [
      "Sporting",
      "Toys",
      "Electronics",
      "Shoes",
      "Pet",
      "Cleaning",
      "Household Paper",
      "Dairy",
      "Adult Beverages",
      "Deli"
    ],
    [
      "Paint",
      "Storage & Laundry",
      "Furniture",
      "Home Office",
      "Girls",
      "Baby",
      "Snacks"
    ],
    [
      "Hardware",
      "Bath",
      "Bedding",
      "Kitchen & Dining",
      "Crafts",
      "Boys",
      "Mens",
      "Grocery",
      "Meat"
    ],
    [
      "Auto",
      "Home",
      "Kitchen & Dining",
      "Celebrate",
      "Sleepwear & Panties",
      "Jewelry & Accessories",
      "Frozen",
      "Meat"
    ],
    [
      "Clearance",
      "Garden",
      "Cosmetics",
      "Kitchen & Dining",
      "Seasonal",
      "Ladies",
      "Fresh Produce",
      "Bakery"
    ],
    [
      "Garden",
      "Health",
      "Health & Wellness",
      "Checkout",
      "Checkout",
      "Checkout"
    ]
  ];*/
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
