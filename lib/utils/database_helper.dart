
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  //Sutun adları string olarak tanımlanır
  String _ogrenciTablo = 'ogrenci';
  String _columnID = 'id';
  String _columnIsim = 'isim';
  String _columnAktif = 'aktif';

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper =  DatabaseHelper._internal();
    }
    return _databaseHelper;
  }

  Future<Database> _getDatabase() async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {

    Directory klasor = await getApplicationDocumentsDirectory();// C://Users/Emre/ogrenci.db
    String path = join(klasor.path, "ogrenci.db");
    print("Olusan veritabanının tam yolu : $path");

    var ogrenciDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return ogrenciDB;

  }

  Future _createDB(Database db, int version) async {
      await db.execute("CREATE TABLE $_ogrenciTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif TEXT )");
  }
}