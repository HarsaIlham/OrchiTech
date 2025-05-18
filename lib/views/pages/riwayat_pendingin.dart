import 'package:flutter/material.dart';
import '../../widget/appbar.dart';

class RiwayatPendingin extends StatefulWidget {
  const RiwayatPendingin({super.key});
  static const routeName = '/riwayatpendingin';

  @override
  State<RiwayatPendingin> createState() => _RiwayatPendinginState();
}

class _RiwayatPendinginState extends State<RiwayatPendingin> {
  List<Map<String, String>> riwayat = [
    {'tanggal': '21 April 2025', 'suhu': '30°C', 'waktu': '08.30'},
    {'tanggal': '21 April 2025', 'suhu': '32°C', 'waktu': '09.30'},
    {'tanggal': '21 April 2025', 'suhu': '31°C', 'waktu': '10.30'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
        title: 'Riwayat Pendingin',
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
              'Pendingin Terakhir Aktif',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                          Expanded(flex: 3, child: Text(item['tanggal'] ?? '')),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.green.withAlpha(25),
                              child: Text(
                                item['suhu'] ?? '',
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
