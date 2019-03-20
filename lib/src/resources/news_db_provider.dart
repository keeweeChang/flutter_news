import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

const itemsTableName = "Items";

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }
  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute("""
          CREATE TABLE $itemsTableName
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  //TODO: Store and fetch top ids.
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
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

  Future<int> addItem(ItemModel itemModel) {
    try {
      //return fakeAdd();
      return db.insert(
        itemsTableName,
        itemModel.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e.toString());
      return fakeAdd();
    }
  }

  Future<int> fakeAdd() async {
    return 1;
  }

  Future<int> clear() {
    return db.delete(itemsTableName);
  }
}

final newsDbProvider = NewsDbProvider();
