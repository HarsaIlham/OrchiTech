// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:orchitech/controllers/aktivasi_pendingin_controller.dart';
import 'package:orchitech/controllers/sensor_suhu_controller.dart';
import 'package:orchitech/provider/status_pendingin_provider.dart';
import 'package:orchitech/views/pages/riwayat_pendingin.dart';
import 'package:provider/provider.dart';
import '/widget/appbar.dart';
import 'package:numberpicker/numberpicker.dart';

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({super.key});
  static const routeName = '/suhuscreen';

  @override
  State<SuhuScreen> createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  final _pendinginController = AktivasiPendinginController();
  final _suhuController = SensorSuhuController();
  final _controller = ValueNotifier<bool>(false);
  late StreamSubscription _statusSub;
  double suhu = 0.0;
  int kelembaban = 0;
  int batassuhu = 0;
  String desKelembaban = "";
  bool _updateBySistem = false;

  /// Mendengarkan perubahan status pendingin dari database.
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<StatusPendinginProvider>();
      _controller.value = provider.status; // Inisialisasi awal

      provider.addListener(() {
        if (_controller.value != provider.status) {
          _updateBySistem = true;
          _controller.value = provider.status;
        }
      });
    });

    _controller.addListener(() {
      if (_updateBySistem) {
        _updateBySistem = false;
        return;
      }

      print("UPDATE BY USER = ${_controller.value}");
      _pendinginController.editStatusPendingin(_controller.value);
    });
  }

  @override
  void dispose() {
    _statusSub.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _editSuhu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int tempValue = batassuhu; // Buat variabel sementara
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: Text(
                'Pilih Batas Suhu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: NumberPicker(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                value: tempValue,
                minValue: 0,
                maxValue: 50,
                haptics: true,
                onChanged: (value) => setStateDialog(() => tempValue = value),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pendinginController.editBatasSuhu(tempValue);
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C7C56),
                  ),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Suhu dan Kelembaban',
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: _suhuController.sensorStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data!;
                if (data.kelembaban < 30) {
                  desKelembaban = "Kering";
                } else if (data.kelembaban >= 30 && data.kelembaban <= 70) {
                  desKelembaban = "Sedang";
                } else {
                  desKelembaban = "Lembab";
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suhu:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 0,
                            ),
                          ),
                          Text(
                            '${data.suhu}°C',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              height: 0,
                              color: Color.fromRGBO(3, 68, 45, 1),
                            ),
                          ),
                          Text(
                            'Celcius',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kelembaban:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 0,
                            ),
                          ),
                          Text(
                            '${data.kelembaban} %',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              height: 0,
                              color: Color.fromRGBO(3, 68, 45, 1),
                            ),
                          ),
                          Text(
                            '$desKelembaban',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Aktifkan/Matikan Sekarang',
                      style: TextStyle(fontSize: 14),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black.withOpacity(0.2)),
                    ),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    trailing: AdvancedSwitch(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      controller: _controller,
                      height: 50.0,
                      width: 100.0,
                      activeChild: Text(
                        'ON',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      inactiveChild: Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                StreamBuilder(
                  stream: _pendinginController.getDatabaseStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data!;
                    batassuhu = data.batasSuhu;
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          'Batas Suhu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          'Pendingin aktif pada suhu',
                          style: TextStyle(fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit_square, color: Colors.black),
                            Text(
                              '$batassuhu°C',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        tileColor: const Color.fromARGB(255, 255, 255, 255),
                        onTap: _editSuhu,
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      'Riwayat Pendingin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black.withOpacity(0.2)),
                    ),
                    tileColor: Colors.white,
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(RiwayatPendingin.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
