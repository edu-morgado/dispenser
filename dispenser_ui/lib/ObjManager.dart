
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

  ObjHome home;
  ListWishList wishlists = ListWishList();
  ListFoodItem foodItems = ListFoodItem();
  ListInventory inventories = ListInventory();
  ListNote notes = ListNote();
  DateTime homeLastRequest;
  DateTime categoriesLastRequest;
  DateTime foodItemsLastRequest;
  DateTime foodRepositoriesLastRequest;
  DateTime notesLastRequest;
  
  
  void saveHome() {
    fileHandler.writeToFile(home, "home.txt");
  }

  Future<bool> loadhomeFromFile() async{
    var json = await fileHandler.readFromFile("home.txt");
    if(json == null) return false;
    home = ObjHome.fromJson(json);
    return true;
  }
    Future<bool> deleteHome() async {
    await fileHandler.delete("home.txt");
    home = null;
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
