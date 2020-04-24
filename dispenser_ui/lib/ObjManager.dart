import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dispenser_ui/Request.dart';
import 'package:dispenser_ui/objects/WishList.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/Inventory.dart';
import 'package:dispenser_ui/objects/Home.dart';
import 'package:dispenser_ui/objects/Note.dart';

class Manager extends ChangeNotifier {
  FileHandler fileHandler = FileHandler();

  int id;
  String name;

  ListWishList wishlists = ListWishList();
  ListFoodItem foodItems = ListFoodItem();
  ListInventory inventories = ListInventory();
  ListNote notes = ListNote();
  DateTime homeLastRequest;
  DateTime categoriesLastRequest;
  DateTime foodItemsLastRequest;
  DateTime foodRepositoriesLastRequest;
  DateTime notesLastRequest;

  /*******************************************************************
   * ***************************Home related requests *************
   ******************************************************************/

  Future<bool> getHomeInfo(int id) async {
    var json = await Requests.readHome(id);

    if (json == null) return null;

    this.id = json['id'];
    this.name = json['name'];
    return true;
  }

  Future<bool> getHomeWishLists() async {
    print("\n******** Starting loading All Home WishLists with the Food in it\n\n");


    if (await getWishLists(this.id) == null) {
      print("Couldnt load WishLists from Home");
      return null;
    }

    for (int i = 0; i < this.wishlists.wishlists.length; i++) {
      if (await getFoodItemsFromWishList(this.wishlists.wishlists[i]) == null) {
        print("Couldnt load FoodItems from WishLists");
        return null;
      }
    }
    print("\n******** Finished loading All Home WishLists with the Food in it\n\n");
    return true;
  }

  Future<bool> getHomeInventories() async {
        print("\n******** Starting loading All Home Inventories with the Food in it\n\n");

    if (await getInventories(this.id) == null) {
      print("Couldnt load Inventories from Home");
      return null;
    }
    for (int i = 0; i < this.inventories.inventories.length; i++) {
      if (await getFoodItemsFromInventory(this.inventories.inventories[i]) ==
          null) {
        print("Couldnt load FoodItems from Inventories");
        return null;
      }
    }
    print("\n******** Finished loading All Home Inventories with the Food in it\n\n");
    return true;
  }

  Future<bool> getEntireHomeInformation(int j) async {
    if (await getHomeInfo(j) == null) {
      print("Not possible to sucessfully load all home items");
      return null;
    }
    if (await getHomeWishLists() == null) {
      print("Not possible to sucessfully load all home items");
      return null;
    }
    if (await getHomeInventories() == null) {
      print("Not possible to sucessfully load all home items");
      return null;
    }

    saveHome();
    saveInventories();
    saveWishLists();
    print("Succsefull!! youve loaded the entire home ");
    return true;
  }

  /*******************************************************************
   * ***********************Food Items related requests *************
   ******************************************************************/

  Future<List<ObjFoodItem>> getFoodItemsFromInventory(
      ObjInventory inventory) async {
    var listJson = await Requests.readFoodItemsFromInventory(inventory.id);
    if (listJson == null) return null;
    inventory.foodItems = [];
    for (var json in listJson) {
      dynamic foodDTO = {
        'id': json['id'],
        'name': json['name'],
        'quantity': json['quantity'],
        'category': json['category'],
        'dateCreated': json['date_created'],
        'dateLastUpdated': json['date_last_update']
      };
     // print(foodDTO);
      inventory.foodItems.add(ObjFoodItem.fromJson(foodDTO));
    }
    saveInventories();
    return inventory.foodItems;
  }

  Future<List<ObjFoodItem>> getFoodItemsFromWishList(
      ObjWishList wishlist) async {
    var listJson = await Requests.readFoodItemsFromWishList(wishlist.id);
    if (listJson == null) return null;

    wishlist.foodItems = [];
    for (var json in listJson) {
      dynamic foodDTO = {
        'id': json['id'],
        'name': json['name'],
        'quantity': json['quantity'],
        'category': json['category'],
        'dateCreated': json['date_created'],
        'dateLastUpdated': json['date_last_update']
      };
      //print(foodDTO);
      wishlist.foodItems.add(ObjFoodItem.fromJson(foodDTO));
    }
    saveWishLists();
    return wishlist.foodItems;
  }

  /*******************************************************************
   * ***********************Inventories related requests *************
   ******************************************************************/

  Future<ListInventory> getInventories(int homeID) async {
    var listJson = await Requests.readInventoriesFromHome(homeID);

    if (listJson == null) return null;

    inventories.inventories = [];
    for (var json in listJson) {
      dynamic inventoryDTO = {
        'id': json['id'],
        'name': json['name'],
        'ttype': json['ttype'],
        'dateCreated': json['date_created'],
        'dateLastUpdated': json['date_last_update']
      };
      //print(inventoryDTO);
      inventories.inventories.add(ObjInventory.fromJson(inventoryDTO));
    }

    saveInventories();
    return inventories;
  }

  Future<ObjInventory> getInventory(int id) async {
    var json = await Requests.readInventory(id);
    if (json == null) return null;

    dynamic inventoryDTO = {
      'id': json['id'],
      'name': json['name'],
      'ttype': json['ttype'],
      'dateCreated': json['date_created'],
      'dateLastUpdated': json['date_last_update']
    };
    ObjInventory inventory = ObjInventory.fromJson(json);
    inventories.inventories.add(inventory);
    saveInventories();
    return inventory;
  }

  /*******************************************************************
   * ***********************Wishlists related requests *************
   ******************************************************************/

  Future<ListWishList> getWishLists(int homeID) async {
    var listJson = await Requests.readWishListsFromHome(homeID);

    if (listJson == null) return null;

    wishlists.wishlists = [];
    for (var json in listJson) {
      dynamic wishlistDTO = {
        'id': json['id'],
        'name': json['name'],
        'dateCreated': json['date_created'],
        'dateLastUpdated': json['date_last_update']
      };
      //print(wishlistDTO);
      wishlists.wishlists.add(ObjWishList.fromJson(wishlistDTO));
    }

    saveInventories();
    return wishlists;
  }

  /*******************************************************************
   *   ******************************************************************
   * ***********************LOCAL STORAGE RELATED FUNCTIONS related requests
   *   ******************************************************************
   ******************************************************************/

  saveHome() {
    fileHandler.writeToFile({'id': this.id, 'name': this.name}, "home.txt");
  }

   saveFoodItems() {
    fileHandler.writeToFile(foodItems, "foodItems.txt");
  }

  Future<bool> loadFoodItemsFromFile() async {
    var json = await fileHandler.readFromFile("foodItems.txt");
    if (json == null) return false;
    foodItems = ListFoodItem.fromJson(json);
    return true;
  }

  Future<bool> deleteFoodItems() async {
    await fileHandler.delete("foodItems.txt");
    foodItems = null;
    return true;
  }

  saveInventories() {
    fileHandler.writeToFile(inventories, "inventories.txt");
  }

  Future<bool> loadInventoriesFromFile() async {
    var json = await fileHandler.readFromFile("inventories.txt");
    if (json == null) return false;
    inventories = ListInventory.fromJson(json);
    return true;
  }

  Future<bool> deleteInventories() async {
    await fileHandler.delete("inventories.txt");
    inventories = null;
    return true;
  }

  saveWishLists() {
    fileHandler.writeToFile(wishlists, "wishlists.txt");
  }

  Future<bool> loadWishListsFromFile() async {
    var json = await fileHandler.readFromFile("wishlists.txt");
    if (json == null) return false;
    wishlists = ListWishList.fromJson(json);
    return true;
  }

  Future<bool> deleteWishList() async {
    await fileHandler.delete("wishlists.txt");
    wishlists = null;
    return true;
  }

  saveNotes() {
    fileHandler.writeToFile(notes, "notes.txt");
  }

  Future<bool> loadNotesFromFile() async {
    var json = await fileHandler.readFromFile("notes.txt");
    if (json == null) return false;
    notes = ListNote.fromJson(json);
    return true;
  }

  Future<bool> deleteNotes() async {
    await fileHandler.delete("notes.txt");
    notes = null;
    return true;
  }
}

class FileHandler {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await localPath;
    return File(path + '/' + fileName);
  }

  Future<File> writeToFile(var obj, String fileName) async {
    String json = jsonEncode(obj);
    File file = await _localFile(fileName);
    return file.writeAsString(json);
  }

  Future<bool> exists(String filename) async {
    return (await _localFile(filename)).exists();
  }

  Future<File> delete(String filename) async {
    if (!await exists(filename)) return null;
    return (await _localFile(filename)).delete();
  }

  Future<Map<String, dynamic>> readFromFile(String filename) async {
    try {
      final file = await _localFile(filename);

      String contents = await file.readAsString();
      Map objMap = jsonDecode(contents);

      return objMap;
    } catch (e) {
      // If encountering an error, return 0.
      return null;
    }
  }
}
