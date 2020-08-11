import 'package:en_notes/db/word_dao.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  final String _dbName = "ennotes_app.db";
  final int _dbVersion = 1;

  static Database _db;
  static DatabaseProvider _instance;

  static Future<DatabaseProvider> getInstance() async {
    if (_instance == null || _db == null) {
      _instance = DatabaseProvider._internal();
      await _instance._init();
    }
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> db() async {
    return _db ??= await _init();
  }

  // open the database
  Future<Database> _init() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    if (_db != null && _db.isOpen) {
      debugPrint("init DB: ALREADY");
      return _db;
    }
    _db = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: (Database db, int version) async {
          debugPrint("created Content");
          // create tables
          var batch = db.batch();
          batch.execute(WordDao().createTableQuery);
          await batch.commit();
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          // for migration
          /*var batch = db.batch();
          if (oldVersion == 1) {
            _updateTableContentV1toV2(batch);
          }
          await batch.commit();*/
        }
    );
    debugPrint("init DB: $path");
    return _db;
  }

  // close database
  Future reOpenDB() async {
    await _db?.close();
    await _init();
  }

  // delete database
  Future delete() async {
    debugPrint("init DB: delete()");
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    await deleteDatabase(path);
    await _db?.close();
    _db = null;
  }


  /// DATABASE MIGRATION Version [Sample]
  /// ---------------------------------------------------------------------
//  /// db v2, create Content table for db v2
//  void _createTableContentV2(Batch batch) async {
//    batch.execute('DROP TABLE IF EXISTS ${ContentDao().tableName}');
//    batch.execute(ContentDao().createTableQuery);
//  }
//
//  /// db v2, add new column 'isUpdated' into 'ContentDAO'
//  void _updateTableContentV1toV2(Batch batch) async {
//    batch.execute('ALTER TABLE ${ContentDao().tableName} ADD ${ContentDao().colIsUpdated} INTEGER');
//  }
  /// ---------------------------------------------------------------------
}
