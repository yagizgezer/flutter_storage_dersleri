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
  var formKey = GlobalKey<FormState>();
  String isim = "";
  bool aktiflik = false;
  List<Ogrenci> tumOgrenciListesi;

  @override
  void initState() {
    super.initState();
    tumOgrenciListesi = List<Ogrenci>();
    databaseHelper = DatabaseHelper();
    databaseHelper.tumOgrenciler().then((mapListesi) {
      for (Map okunanMap in mapListesi) {
        tumOgrenciListesi.add(Ogrenci.fromMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SqfLite Kullanimi"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Öğrenci ismini giriniz",
                        border: OutlineInputBorder(),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length < 3) {
                          return "En az 3 karakter giriniz";
                        }
                      },
                      onSaved: (girilenIsim) {
                        isim = girilenIsim;
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text(
                      "Aktif",
                    ),
                    value: aktiflik,
                    onChanged: (aktifMi) {
                      setState(() {
                        aktiflik = aktifMi;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Kaydet"),
                  color: Colors.green,
                  onPressed: () {

                    if(formKey.currentState.validate()){

                      formKey.currentState.save();
                      _ogrenciEkle(Ogrenci(isim,aktiflik));
                    }


                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: tumOgrenciListesi.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: tumOgrenciListesi[index].aktif == true ? Colors.green.shade200 : Colors.red.shade200,
                      child: ListTile(
                        title: Text(tumOgrenciListesi[index].isim),
                        subtitle: Text(tumOgrenciListesi[index].id.toString()),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

   _ogrenciEkle(Ogrenci ogrenci) async{

    await databaseHelper.ogrenciEkle(ogrenci).then((eklenenInt){

      setState(() {
        ogrenci.id=eklenenInt;
        tumOgrenciListesi.insert(0, ogrenci);
      });
    });

  }
}
