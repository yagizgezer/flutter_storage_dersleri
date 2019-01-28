import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/model/ogrenci.dart';
import 'package:flutter_storage_dersleri/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteIslemleri extends StatefulWidget {
  @override
  _SqfliteIslemleriState createState() => _SqfliteIslemleriState();
}

class _SqfliteIslemleriState extends State<SqfliteIslemleri> {
  @override
  Widget build(BuildContext context) {

    Ogrenci emre=Ogrenci.withID(10, "emre", true);
    Map olusanMap = emre.toMap();
    debugPrint(olusanMap['ad_soyad'].toString());

    Ogrenci kopyaEmre = Ogrenci.fromMap(olusanMap);
    debugPrint(kopyaEmre.toString());
    var aa=DatabaseHelper().;
    var bb=DatabaseHelper();
    var cc=DatabaseHelper();



    return Scaffold(
      appBar: AppBar(title: Text("SqfLite Kullanimi"),),
      body: Center(child: Text("Boş"),),
    );
  }
}
