import 'package:flutter/material.dart';
import 'package:orchitech/controllers/riwayat_penyiraman_controller.dart';
import 'package:orchitech/extension/riwayat_extensions.dart';
import 'package:orchitech/models/riwayat_penyiraman_model.dart';
import '../../widget/appbar.dart';

class RiwayatPenyiraman extends StatefulWidget {
  const RiwayatPenyiraman({super.key});
  static const String routeName = '/riwayatpenyiraman';

  @override
  State<RiwayatPenyiraman> createState() => _RiwayatPenyiramanState();
}

class _RiwayatPenyiramanState extends State<RiwayatPenyiraman> {
  final _controller = RiwayatPenyiramanController();
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.start,
            ),
            Expanded(
              child: StreamBuilder<List<RiwayatPenyiramanModel>>(
                stream: _controller.showRiwayat(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Data riwayat pendingin kosong'));
                  }

                  final riwayatList = snapshot.data!;
                  return ListView.builder(
                    itemCount: riwayatList.length,
                    itemBuilder: (context, index) {
                      final item = riwayatList[index];
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
                              Expanded(
                                flex: 3,
                                child: Text(item.tanggalIndo),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  color: Colors.green.withAlpha(25),
                                  child: Text(
                                    item.hariIndo,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  item.jamIndo,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
