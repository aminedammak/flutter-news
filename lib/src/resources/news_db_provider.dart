import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewDbProvider {
  Database db;

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
        newDb.execute("""CREATE TABLE items (
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
}
