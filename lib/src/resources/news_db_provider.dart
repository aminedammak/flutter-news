import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  //TODO: fetch and store ids
  Future<List<int>> fetchTopIds() async {
    final List<int> ids = [1, 2, 3];
    return ids;
  }

  init() async {
    //Create a reference to a location inside the device's memery
    Directory dbDirectory = await getApplicationDocumentsDirectory();
    final path = join(dbDirectory.path, "items.db");
    //Create if the app newly installed, or open the DB
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        //Invoked only if the user is opening the app for the very first time
        newDb.execute("""CREATE TABLE Items (
          id INTEGER PRIMARY KEY, 
          deleted INTEGER,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          dead INTEGER,
          parent INTEGER,
          kids BLOB,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        """);
      },
    );
  }

  Future<ItemModel?> fetchItem(id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int>? addItem(ItemModel? item) {
    if (item != null) {
      return db.insert("Items", item.toMap());
    }
  }
}

final newsDbProvider = NewsDbProvider();
