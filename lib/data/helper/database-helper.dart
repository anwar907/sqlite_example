import 'dart:io' as io;

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
    io.Directory directoryDocument = await getApplicationDocumentsDirectory();
    String path = join(directoryDocument.path, "user.db");
    var locationDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return locationDb;
  }

  //create table when new data do insert
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, email VARCHAR, username TEXT, password TEXT)");
  }

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert('$tabelUser', user.toJson());
    return res;
  }

  //validate user akun
  Future<User> selectUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tabelUser WHERE "
        "$columnEmail = '$email' AND "
        "$columnPassword = '$password' ");
    if (res.length > 0) {
      return User.fromJson(res.first);
    }
    return null;
  }
}
