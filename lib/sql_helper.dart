import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute(""" CREATE TABLE items2(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    weight TEXT,
    _id TEXT,
    user TEXT,
    video_title TEXT,
    thumbnail TEXT,
    video_id TEXT,
    type TEXT,
    cat TEXT,
    package TEXT,
    SIV TEXT,
    status TEXT,
    duration TEXT,
    view TEXT,
    createdAt TEXT,
    uploadtime TEXT,
    modifiedAt TEXT,
    __v TEXT
    )
    """);
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      'simple2.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        print(">>>creating a table");
        await createTables(database);
      }
    );
  }

  static Future<int> createItem(
  String? weight,
      String? _id,
      String? user,
      String? video_title,
      String? thumbnail,
      String? video_id,
      String? type,
      String? cat,
      String? package,
      String? SIV,
      String? status,
      String? duration,
      String? view,
      String? createdAt,
      String? uploadtime,
      String? modifiedAt,
      String? __v
      ) async{
    final db = await SQLHelper.db();

    final data = {
      'weight': weight.toString(),
      '_id': _id.toString(),
      'user':user.toString(),
      'video_title':video_title.toString(),
      'thumbnail':thumbnail.toString(),
      'video_id':video_id.toString(),
      'type':type.toString(),
      'cat':cat.toString(),
      'package':package.toString(),
      'SIV':SIV.toString(),
      'status':status.toString(),
      'duration':duration.toString(),
      'view':view.toString(),
      'createdAt':createdAt.toString(),
      'uploadtime':uploadtime.toString(),
      'modifiedAt':modifiedAt.toString(),
      '__v':__v.toString(),
    };

    final id = await db.insert('items2', data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async{
      final db = await SQLHelper.db();
      return db.query('items2', orderBy: "id");
  }
  static Future<List<Map<String, dynamic>>> getItem(int id) async{
      final db = await SQLHelper.db();
      return db.query('items2', where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteItem(int id) async{
    final db = await SQLHelper.db();
    try{
      await db.delete('items2', where: "id = ?", whereArgs: [id]);
    } catch (err){
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}