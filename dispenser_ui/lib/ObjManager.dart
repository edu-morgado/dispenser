
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dispenser_ui/objects/WishList.dart';
import 'package:dispenser_ui/objects/FoodItem.dart';
import 'package:dispenser_ui/objects/Inventory.dart';
import 'package:dispenser_ui/objects/Home.dart';
import 'package:dispenser_ui/objects/Note.dart';

class Manager extends ChangeNotifier{
  FileHandler fileHandler = FileHandler();

  ListWishList wishlists = ListWishList();
  ListFoodItem foodItems = ListFoodItem();
  ListInventory inventories = ListInventory();
  ListNote notes = ListNote();
  DateTime homeLastRequest;
  DateTime categoriesLastRequest;
  DateTime foodItemsLastRequest;
  DateTime foodRepositoriesLastRequest;
  DateTime notesLastRequest;
  
  
  saveFoodItems() {
    fileHandler.writeToFile(foodItems, "foodItems.txt");
  }

  Future<bool> loadFoodItemsFromFile() async {
    var json = await fileHandler.readFromFile("foodItems.txt");
    if(json == null) return false;
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
    if(json == null) return false;
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
    if(json == null) return false;
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
    if(json == null) return false;
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
