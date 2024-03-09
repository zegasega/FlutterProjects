import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDataTable(),
    );
  }
}

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController vizeController = TextEditingController();
  TextEditingController finalController = TextEditingController();

  double ortalama = 0.0;
  String harfNotu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ogrenci Not Sistemi'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Ad Soyad')),
                DataColumn(label: Text('Vize')),
                DataColumn(label: Text("Final")),
                DataColumn(label: Text("Ortalama")),
                DataColumn(label: Text("Harf Notu"))
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    TextField(
                      controller: adSoyadController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: vizeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  DataCell(
                    TextField(
                      controller: finalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(ortalama.toString()),
                  ),
                  DataCell(
                    Text(
                      harfNotu,
                      style: TextStyle(
                        color: renkBelirle(harfNotu),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double vize = double.tryParse(vizeController.text) ?? 0;
                  double finalNot = double.tryParse(finalController.text) ?? 0;
                  adSoyadController.text; // Ad Soyad bilgisini alabilirsiniz.

                  ortalama = ortalamaHesapla(vize, finalNot);
                  harfNotu = harfNotuHesapla(ortalama);
                });
              },
              child: Text('Hesapla'),
            ),
          ],
        ),
      ),
    );
  }

  double ortalamaHesapla(double vize, double finalNot) {
    return (vize + finalNot) / 2;
  }

  String harfNotuHesapla(double ortalama) {
    if (ortalama >= 90) {
      return 'AA';
    } else if (ortalama >= 80) {
      return 'BA';
    } else if (ortalama >= 70) {
      return 'BB';
    } else if (ortalama >= 60) {
      return 'CB';
    } else {
      return 'FF';
    }
  }

  Color renkBelirle(String harfNotu) {
    switch (harfNotu) {
      case 'AA':
        return Colors.green;
      case 'BA':
        return Colors.blue;
      case 'BB':
        return Colors.yellow;
      case 'CB':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
