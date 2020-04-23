import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Requests {
  static final String serverURL = "http://192.168.1.78:5000";
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


  /*******************************************************************
   * ***********************Food Items related requests *************
   ******************************************************************/

  static Future<bool> createFoodItem(
      String name, int quantity, String category) async {
    http.Response response;
    try {
      response =
          await _post(Uri.encodeFull("$serverURL/api/food_item/create"), body: {
        "name": name,
        "quantity": quantity.toString(),
        "category": category,
      });
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/food_item/create");
      return false;
    }
    print("Route: $serverURL/api/food_item/create -> ${response.statusCode}");
    return response.statusCode == 201;
  }

  static Future<List<dynamic>> readFoodItems() async {
    http.Response response;
    try {
      response = await _get(Uri.encodeFull("$serverURL/api/food_item/read"));
    } catch (SocketException) {
      print(SocketException.toString());
      print("Exception: No internet!! Route: $serverURL/api/food_item/read");
      return null;
    }
    print("Route: $serverURL/api/food_item/read -> ${response.statusCode}");
    if( response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }




  /*******************************************************************
   * ***********************Inventories related requests *************
   ******************************************************************/


  static Future<List<dynamic>> readInventories() async {
    http.Response response;
    try {
      response = await _get(
        Uri.encodeFull("$serverURL/api/inventory/read"),
      );
    } catch (SocketException) {
      print("Exception: No internet!! Route: $serverURL/api/inventory/read");
      return null;
    }
    print("Route: $serverURL/api/inventory/read -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

  
  /*******************************************************************
   * ***********************Wish List related requests *************
   ******************************************************************/


  static Future<List<dynamic>> readWishLists() async {
    http.Response response;
    try {
      response = await _get(
        Uri.encodeFull("$serverURL/api/wishlist/read"),
      );
    } catch (SocketException) {
      print("Exception: No internet!! Route: $serverURL/api/inventory/read");
      return null;
    }
    print("Route: $serverURL/api/inventory/read -> ${response.statusCode}");
    if (response.statusCode != 200) return null;
    return jsonDecode(response.body);
  }

}
