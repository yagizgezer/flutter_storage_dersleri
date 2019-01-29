
import 'dart:async';
import 'dart:io';

import 'package:flutter_storage_dersleri/model/ogrenci.dart';
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
      print("DATA BASE HELPER NULL, OLUSTURULACAK");
      _databaseHelper =  DatabaseHelper._internal();
      return _databaseHelper;
    }else{
      print("DATA BASE HELPER NULL DEGIL");
      return _databaseHelper;
    }

  }

  Future<Database> _getDatabase() async {
    if(_database == null){
      print("DATA BASE NESNESI NULL, OLUSTURULACAK");
      _database = await _initializeDatabase();
      return _database;
    }else{
      print("DATA BASE NESNESI NULL DEĞİL");
      return _database;
    }

  }

  _initializeDatabase() async {

    Directory klasor = await getApplicationDocumentsDirectory();// C://Users/Emre/ogrenci.db
    String path = join(klasor.path, "ogrenci.db");
    print("Olusan veritabanının tam yolu : $path");

    var ogrenciDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return ogrenciDB;

  }

  Future _createDB(Database db, int version) async {
       print("CREATE DB METHODU CALISTI TABLO OLUSTURULACAK");
      await db.execute("CREATE TABLE $_ogrenciTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif TEXT )");
  }

  Future<int> ogrenciEkle(Ogrenci ogrenci) async{
    var db = await _getDatabase();
    var sonuc = await db.insert(_ogrenciTablo, ogrenci.toMap());
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumOgrenciler() async{
    var db = await _getDatabase();
    var sonuc = db.query(_ogrenciTablo, orderBy: '$_columnID DESC');
    return sonuc;
  }

  Future<int> ogrenciGuncelle(Ogrenci ogrenci) async{
    var db = await _getDatabase();
    var sonuc = db.update(_ogrenciTablo, ogrenci.toMap(), where: '$_columnID = ?', whereArgs: [ogrenci.id]);

    return sonuc;
  }

  Future<int> ogrenciSil(int id) async{

    var db = await _getDatabase();
    var sonuc = db.delete(_ogrenciTablo, where: '$_columnID = ?' , whereArgs: [id]);
    return sonuc;
    
  }






}