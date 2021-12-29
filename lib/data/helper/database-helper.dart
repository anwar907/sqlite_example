import 'dart:developer';
import 'dart:io';

import 'package:majootestcase/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instanse = DatabaseHelper.internal();
  factory DatabaseHelper() => _instanse;

  static Database _db;
  final String tabelUser = "User";
  final String columnEmail = "email";
  final String columnUserName = "username";
  final String columnPassword = "password";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory directoryDocument = await getApplicationDocumentsDirectory();
    String path = join(directoryDocument.path, "user.db");
    var locationDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return locationDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)");
    log("Table is created");
  }

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    log(user.userName);
    int res = await dbClient.insert('User', user.toJson());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    log("Get data all user >>$list");
    return res;
  }

  Future<int> deleteuser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> selectUser(User user) async {
    log("Select User");
    log(user.password);
    var dbClient = await db;

    List<Map> maps = await dbClient.query(tabelUser,
        columns: [columnEmail, columnPassword],
        where: "$columnEmail = ? and $columnPassword = ?",
        whereArgs: [user.email, user.password]);
    log("DATA USER $maps");
    if (maps.length > 0) {
      log("User Exits !!");
      return user;
    } else {
      return null;
    }
  }
}
