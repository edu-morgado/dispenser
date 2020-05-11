import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'objects/FoodItem.dart';
import 'objects/WishList.dart';
import 'objects/Inventory.dart';
import 'objects/Home.dart';

class Requests {
  static final String serverURL = "https://192.168.1.4:5000";
  static http.Client client;

  // Use when multiple requests necessary
  static void openClient() {
    if (client == null) client = http.Client();
  }

  static void closeClient() {
    if (client != null) client.close();
    client = null;
  }

  static Function get _get {
    if (client == null) return http.get;
    return client.get;
  }

  static Function get _post {
    if (client == null) return http.post;
    return client.post;
  }

  static Function get _put {
    if (client == null) return http.put;
    return client.put;
  }

  static Function get _delete {
    if (client == null) return http.delete;
    return client.delete;
  }

  /*******************************************************************
   * ***************************Home related requests ****************
   *******************************************************************/

 static Future<bool> createHome(ObjHome home) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/home/create"), body: {
        "name": home.name,
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/home/create");
      return false;
    }
    print("Route: $serverURL/api/home/create -> ${response.statusCode}");
    if (response.statusCode == 201) {
      var responsejson = jsonDecode(response.body);
      home.id = responsejson['id'];
    }
    return response.statusCode == 201;
  }


  static Future<dynamic> readHome(int id) async {
    http.Response response;
    try {
      print("dengu5e");
      response = await _get(Uri.encodeFull("$serverURL/api/home/read/$id"));
      print("dengu6e");
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/home/read/$id");
      return false;
    }
    print("Route: $serverURL/api/home/read/$id -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  /*******************************************************************
   * ***********************Food Items related requests *************
   ******************************************************************/

  static Future<bool> createFoodItemForInventory(
      ObjFoodItem foodItem, int inventoryID) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/food_item/create"), body: {
        "name": foodItem.name,
        "quantity": foodItem.quantity.toString(),
        "category": foodItem.category,
        "inventory_id": inventoryID.toString(),
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/food_item/create");
      return false;
    }
    print("Route: $serverURL/api/food_item/create -> ${response.statusCode}");
    if (response.statusCode == 201) {
      var responsejson = jsonDecode(response.body);
      foodItem.id = responsejson['id'];
    }
    return response.statusCode == 201;
  }

  static Future<bool> createFoodItemForWishList(
      ObjFoodItem foodItem, int wishlistID) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/food_item/create"), body: {
        "name": foodItem.name,
        "quantity": foodItem.quantity.toString(),
        "category": foodItem.category,
        "wish_list_id": wishlistID.toString(),
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/food_item/create");
      return false;
    }
    print("Route: $serverURL/api/food_item/create -> ${response.statusCode}");
    if (response.statusCode == 201) {
      var responsejson = jsonDecode(response.body);
      foodItem.id = responsejson['id'];
    }
    return response.statusCode == 201;
  }

  static Future<List<dynamic>> readFoodItemsFromInventory(
      int inventoryId) async {
    http.Response response;
    try {
      response = await _post(
          Uri.encodeFull("$serverURL/api/food_item/read_from_inventory"),
          body: {'inventory_id': inventoryId.toString()});
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/food_item/read_from_inventory");
      return null;
    }
    print(
        "Route: $serverURL/api/food_item/read_from_inventory -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> readFoodItemsFromWishList(int wishlistId) async {
    http.Response response;
    try {
      response = await _post(
          Uri.encodeFull("$serverURL/api/food_item/read_from_wishlist"),
          body: {'wishlist_id': wishlistId.toString()});
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/food_item/read_from_wishlist");
      return null;
    }
    print(
        "Route: $serverURL/api/food_item/read_from_wishlist -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<dynamic> readFoodItem(int id) async {
    http.Response response;
    try {
      response =
          await _get(Uri.encodeFull("$serverURL/api/food_item/read/$id"));
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/food_item/read/$id");
      return null;
    }
    print("Route: $serverURL/api/food_item/read/$id -> ${response.statusCode}");
    if (response.statusCode == 200) return null;
    return jsonDecode(response.body);
  }

  static Future<dynamic> updateFoodItem(ObjFoodItem foodItem) async {
    http.Response response;
    try {
      response = await _post(
          Uri.encodeFull("$serverURL/api/food_item/update/${foodItem.id}"),
          body: {
            "name": foodItem.name,
            "quantity": foodItem.quantity.toString(),
            "category": foodItem.category,
          });
    } catch (SocketException) {
      print(
          "Exception: No internet!! Route: $serverURL/api/foodItem/update/${foodItem.id}");
      return null;
    }
    print(
        "Route: $serverURL/api/foodItem/update/${foodItem.id} -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<bool> deleteFoodItem(ObjFoodItem foodItem) async {
    http.Response response;
    try {
      response = await _delete(
          Uri.encodeFull("$serverURL/api/food_item/delete/${foodItem.id}"));
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/food_item/delete/${foodItem.id}");
      return false;
    }
    print(
        "Route: $serverURL/api/foodItem/delete/${foodItem.id} -> ${response.statusCode}");
    return response.statusCode == 204;
  }

  /*******************************************************************
   * ***********************Inventories related requests *************
   ******************************************************************/

  static Future<bool> createInventory(ObjInventory inventory) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/inventory/create"), body: {
        "name": inventory.name,
        'ttype': inventory.ttype.toString(),
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/inventory/create");
      return false;
    }
    print("Route: $serverURL/api/inventory/create -> ${response.statusCode}");
    if (response.statusCode == 201) {
      var responsejson = jsonDecode(response.body);
      inventory.id = responsejson['id'];
    }
    return response.statusCode == 201;
  }

  static Future<List<dynamic>> readInventoriesFromHome(int homeId) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/inventory/read"), body: {
        'homeId': homeId.toString(),
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/inventory/read");
      return null;
    }
    print("Route: $serverURL/api/inventory/read -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<dynamic> readInventory(int id) async {
    http.Response response;
    try {
      response =
          await _get(Uri.encodeFull("$serverURL/api/inventory/read/$id"));
    } catch (SocketException) {
      print(
          "Exception: No internet!! Route: $serverURL/api/inventory/read/$id");
      return null;
    }
    print("Route: $serverURL/api/inventory/read/$id -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<dynamic> updateInventory(ObjInventory inventory) async {
    http.Response response;
    try {
      response = await _post(
          Uri.encodeFull("$serverURL/api/inventory/update/${inventory.id}"),
          body: {
            'name': inventory.name,
            'ttype': inventory.ttype.toString(),
          });
    } catch (SocketException) {
      print(
          "Exception: No internet!! Route: $serverURL/api/inventory/update/${inventory.id}");
      return null;
    }
    print(
        "Route: $serverURL/api/inventory/update/${inventory.id} -> ${response.statusCode}");
    print(inventory);
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<bool> deleteInventory(ObjInventory inventory) async {
    http.Response response;
    try {
      response = _delete(
          Uri.encodeFull("$serverURL/api/inventory/delete/${inventory.id}"));
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/inventory/delete/${inventory.id}");
      return false;
    }
    print(
        "Route: $serverURL/api/inventory/delete/${inventory.id} -> ${response.statusCode}");
    return response.statusCode == 204;
  }

  /*******************************************************************
   * ***********************Wish List related requests *************
   ******************************************************************/
  static Future<bool> createWishList(ObjWishList wishlist) async {
    http.Response response;
    try {
      response = await _post(Uri.encodeFull("$serverURL/api/wishlist/create"),
          body: {"name": wishlist.name});
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/wishlist/create");
      return false;
    }
    print("Route: $serverURL/api/wishlist/create -> ${response.statusCode}");
    if (response.statusCode == 201) {
      var responsejson = jsonDecode(response.body);
      wishlist.id = responsejson['id'];
    }
    return response.statusCode == 201;
  }

  static Future<List<dynamic>> readWishListsFromHome(int homeId) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/wishlist/read"), body: {
        'homeId': homeId.toString(),
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/wishlist/read");
      return null;
    }
    print("Route: $serverURL/api/wishlist/read -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<dynamic> updateWishList(ObjWishList wishlist) async {
    http.Response response;
    try {
      response = await _post(
          Uri.encodeFull("$serverURL/api/wishlist/update/${wishlist.id}"),
          body: {'name': wishlist.name});
    } catch (SocketException) {
      print(
          "Exception: No internet!! Route: $serverURL/api/wishlist/update/${wishlist.id}");
      return null;
    }
    print(
        "Route: $serverURL/api/wishlist/update/${wishlist.id} -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  static Future<bool> deleteWishList(ObjWishList wishlist) async {
    http.Response response;
    try {
      response = _delete(
          Uri.encodeFull("$serverURL/api/wishlist/delete/${wishlist.id}"));
    } catch (SocketException) {
      print(SocketException.toString());
      print(
          "Exception: No internet!! Route: $serverURL/api/wishlist/delete/${wishlist.id}");
      return false;
    }
    print(
        "Route: $serverURL/api/wishlist/delete/${wishlist.id} -> ${response.statusCode}");
    return response.statusCode == 204;
  }
}
