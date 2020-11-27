import 'dart:async';
import 'dart:io' as io;
import 'package:lakleko/models/lisa_access_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelperItem {
  static Database _db;
  static const String ID = "id";
  static const String SITENAME = "siteName";
  static const String SITEURL = "siteUrl";
  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String DATECREATED = "dateCreated";
  static const String TABLE = "access_listTbl";
  static const String DB_NAME = 'lisa_tbl16.db';
//  static const String DB_NAME = 'lisa_tbl3.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $SITENAME TEXT, $SITEURL TEXT, $USERNAME TEXT, $PASSWORD TEXT, $DATECREATED TEXT)");
  }

  Future<int> save(LisaAccessItem lisaAccessItem) async {
    var dbClient = await db;
    int res = await dbClient.insert(TABLE, lisaAccessItem.toMap());
    return res;

    /*await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ( $NAME ) VALUES('" + employee.name + "')";
      return await txn.rawInsert(query);
    });*/
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $TABLE"));
  }

  Future<LisaAccessItem> getItem(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT * FROM $TABLE WHERE id = $ID ");
    //var result = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
    if (result.length == 0) return null;
    return LisaAccessItem.fromMap(result.first);
  }

  Future<List<LisaAccessItem>> getItems() async {
    var dbClient = await db;
    //List<Map> maps = await dbClient.query(TABLE, columns: [ID, ITEMNAME, DATECREATED]);
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $TABLE ORDER BY $DATECREATED DESC");

    List<LisaAccessItem> itemsList = List<LisaAccessItem>();
    int itemCount = maps.length;

    for (int i = 0; i < itemCount; i++) {
      itemsList.add(LisaAccessItem.fromMap(maps[i]));
    }

//    List<NoDoItem>  noDoItem = [];
//
//    if(noDoItem.length > 0 ){
//      for(int i = 0; i < maps.length; i++){
//        noDoItem.add(NoDoItem.fromMap(maps[i]));
//      }
//    }
    //return maps.toList();

    return itemsList;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(LisaAccessItem lisaAccessItem) async {
    var dbClient = await db;
    return dbClient.update(TABLE, lisaAccessItem.toMap(),
        where: '$ID=?', whereArgs: [lisaAccessItem.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
