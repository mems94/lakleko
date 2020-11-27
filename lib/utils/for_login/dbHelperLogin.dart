import 'dart:async';
import 'dart:io' as io;
import 'package:lakleko/models/lisa_login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelperLogin {
  static Database _db;
  static const String ID = "id";
  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String TABLE = "loginTbl";
  static const String DB_NAME = 'lisa_tbl.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory getDocuments = await getApplicationDocumentsDirectory();
    String path = join(getDocuments.path, DB_NAME);
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $USERNAME TEXT, $PASSWORD TEXT)");
  }

  Future<int> save(LisaLogin lisaLogin) async {
    var dbClient = await db;

    int res = await dbClient.insert(TABLE, lisaLogin.toMap());

    return res;

    /*await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ( $NAME ) VALUES('" + employee.name + "')";
      return await txn.rawInsert(query);
    });*/
  }

//  Future<int> getCount() async {
//    var dbClient = await db;
//    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $TABLE"));
//  }

//  Future<LisaLogin> getItem(int id) async{
//    var dbClient = await db;
//    var result = await dbClient.rawQuery("SELECT * FROM $TABLE WHERE id = $ID ");
//    //var result = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
//    if(result.length == 0) return null;
//    return LisaLogin.fromMap(result.first);
//
//  }

  Future<LisaLogin> getItem(String username, String password) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $TABLE WHERE $USERNAME = '$username' AND $PASSWORD = '$password'");
    //var result = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
    if (result.length == 0) return null;
    return LisaLogin.fromMap(result.first);
  }

//  Future<List<NoDoItem>> getItems() async {
//
//    var dbClient = await db;
//    //List<Map> maps = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
//    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE ORDER BY $DATECREATED DESC");
//
//    List<NoDoItem> itemsList = List<NoDoItem>();
//    int itemCount = maps.length;
//
//    for(int i=0;i<itemCount;i++){
//       itemsList.add(NoDoItem.fromMap(maps[i]));
//    }

//    List<NoDoItem>  noDoItem = [];
//
//    if(noDoItem.length > 0 ){
//      for(int i = 0; i < maps.length; i++){
//        noDoItem.add(NoDoItem.fromMap(maps[i]));
//      }
//    }
  //return maps.toList();
//
//    return itemsList;
//  }

//  Future<int> delete(int id) async {
//    var dbClient = await db;
//    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs:[id]);
//  }

//  Future<int> update(NoDoItem noDoItem) async{
//    var dbClient = await db;
//    return dbClient.update(TABLE, noDoItem.toMap(),
//        where: '$ID=?',
//        whereArgs: [noDoItem.id]);
//  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
