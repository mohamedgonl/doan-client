import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  // SQLHelper._();
  // static final SQLHelper db = SQLHelper._();

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE backgrounds(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        bg_id TEXT,
        url TEXT,
        metadata TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Database? _database;

  static Future<sql.Database> db() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = await sql.getDatabasesPath();
    String path = dbPath + '/background.db';
    if (_database != null) {
      return _database!;
    } else {
      _database = await sql.openDatabase(
        path,
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        },
        //singleInstance: true,
      );
      return _database!;
    }
  }

  // Create new item (journal)
  static Future<int> createItem(
      String backgroundId, String url, String? metadata) async {
    final db = await SQLHelper.db();

    final data = {
      'bg_id': backgroundId,
      'url': url,
      'metadata': metadata,
    };
    final id = await db.insert('backgrounds', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('backgrounds', orderBy: "bg_id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(String backgroundId) async {
    final db = await SQLHelper.db();
    return db.query('backgrounds',
        where: "bg_id = ?", whereArgs: [backgroundId], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getItemWithMetadata(
      String metadata) async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        'SELECT * FROM backgrounds WHERE metadata LIKE ?;', [metadata]);
    // return db.query('backgrounds',
    //     where: "metadata = ?", whereArgs: [metadata], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String backgroundId, String url, String? metadata) async {
    final db = await SQLHelper.db();

    final data = {
      'bg_id': backgroundId,
      'url': url,
      'metadata': metadata,
      'createdAt': DateTime.now().toString()
    };

    final result = await db.update('backgrounds', data,
        where: "bg_id = ?", whereArgs: [backgroundId]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int backgroundId) async {
    final db = await SQLHelper.db();
    try {
      await db
          .delete("backgrounds", where: "bg_id = ?", whereArgs: [backgroundId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

class DatabaseItem {
  String? bgId;
  String? url;
  String? metadata;

  DatabaseItem({this.bgId, this.url, this.metadata});

  DatabaseItem.fromJson(Map<String, dynamic> json) {
    bgId = json['bg_id'];
    url = json['url'];
    metadata = json['metadata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bg_id'] = bgId;
    data['url'] = url;
    data['metadata'] = metadata;
    return data;
  }
}
