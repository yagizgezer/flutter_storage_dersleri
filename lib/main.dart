import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/dosya_islemleri.dart';
import 'package:flutter_storage_dersleri/shared_pref_kullanimi.dart';
import 'package:flutter_storage_dersleri/sqlflite_islemleri.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SqfliteIslemleri(),
    );
  }
}
