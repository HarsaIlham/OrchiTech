import 'package:flutter/material.dart';
import 'package:orchitech/controllers/riwayat_pendingin_controller.dart';
import 'package:orchitech/extension/riwayat_extensions.dart';
import 'package:orchitech/models/riwayat_pendingin_model.dart';  // PASTIKAN import model yang benar
import '../../widget/appbar.dart';

class RiwayatPendingin extends StatefulWidget {
  const RiwayatPendingin({super.key});
  static const routeName = '/riwayatpendingin';

  @override
  State<RiwayatPendingin> createState() => _RiwayatPendinginState();
}

class _RiwayatPendinginState extends State<RiwayatPendingin> {
  final _controller = RiwayatPendinginController();

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
              child: StreamBuilder<List<RiwayatPendinginModel>>(
                stream: _controller.showRiwayat(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Loading indicator saat menunggu data stream
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Jika data kosong
                    return Center(child: Text('Data riwayat pendingin kosong'));
                  }

                  // Data sudah ada dan valid
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
                                child: Text(
                                  // Format tanggal sesuai kebutuhan
                                  item.tanggalIndo, 
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  color: Colors.green.withAlpha(25),
                                  child: Text(
                                    item.suhu.toString(), // Misal status adalah suhu atau info lain
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  // Format waktu dari createdAt jika perlu
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
