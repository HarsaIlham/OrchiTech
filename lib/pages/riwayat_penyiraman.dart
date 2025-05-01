import 'package:flutter/material.dart';
import 'package:orchitech/widget/appbar.dart';

class RiwayatPenyiraman extends StatefulWidget {
  const RiwayatPenyiraman({super.key});
  static const String routeName = '/riwayatpenyiraman';

  @override
  State<RiwayatPenyiraman> createState() => _RiwayatPenyiramanState();
}

class _RiwayatPenyiramanState extends State<RiwayatPenyiraman> {
  List<Map<String, String>> riwayat = [
    {"jalur": "Jalur Penyiraman 1", "hari": "Senin", "waktu": "08:30 AM"},
    {"jalur": "Jalur Penyiraman 2", "hari": "Senin", "waktu": "09:30 AM"},
    {"jalur": "Jalur Penyiraman 1", "hari": "Selasa", "waktu": "08:30 AM"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
        title: 'Riwayat Penyiraman',
        icon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Penyiraman Terakhir Aktif',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: riwayat.length,
                itemBuilder: (context, index) {
                  final item = riwayat[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text(item['jalur'] ?? '')),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.green.withAlpha(25),
                              child: Text(
                                item['hari'] ?? '',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item['waktu'] ?? '',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
