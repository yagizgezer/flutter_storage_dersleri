import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/model/ogrenci.dart';
import 'package:flutter_storage_dersleri/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteIslemleri extends StatefulWidget {
  @override
  _SqfliteIslemleriState createState() => _SqfliteIslemleriState();
}

class _SqfliteIslemleriState extends State<SqfliteIslemleri> {

  DatabaseHelper databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {

    _ekle();



    return Scaffold(
      appBar: AppBar(title: Text("SqfLite Kullanimi"),),
      body: Center(child: Text("Boş"),),
    );
  }

  _ekle() async{
    await databaseHelper.ogrenciEkle(Ogrenci("yeni1",true));
    await databaseHelper.ogrenciEkle(Ogrenci("yeni2",true));
    await databaseHelper.ogrenciEkle(Ogrenci("yeni2",true));
    await databaseHelper.ogrenciEkle(Ogrenci("yeni2",true));
    await databaseHelper.ogrenciEkle(Ogrenci("yeni2",true));
    await databaseHelper.ogrenciEkle(Ogrenci("yeni2",true));
  }
}
