import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:orchitech/pages/riwayat_pendingin.dart';
import '/widget/appbar.dart';
import '../service.dart';
import 'package:numberpicker/numberpicker.dart';

class ScreenSuhu extends StatefulWidget {
  const ScreenSuhu({super.key});
  static const routeName = '/suhuscreen';

  @override
  State<ScreenSuhu> createState() => _ScreenSuhuState();
}

class _ScreenSuhuState extends State<ScreenSuhu> {
  final FirebaseService _firebaseService = FirebaseService();
  final _controller = ValueNotifier<bool>(false);
  double suhu = 0.0;
  int kelembaban = 0;
  int batassuhu = 0;
  String desKelembaban = "";

  @override
  void initState() {
    super.initState();
    getLatestData();
  }

  void _editSuhu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int tempValue = batassuhu; // Buat variabel sementara
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: Text('Pilih Batas Suhu',
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
                  child: Text('Simpan', 
                  style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold),),
                  onPressed: () {
                    setState(() {
                      batassuhu = tempValue;
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C7C56),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void getLatestData() async {
    _firebaseService.getLatestStatus().listen((status) {
      if (status != null) {
        setState(() {
          final idSuhu = status.idSuhu;
          batassuhu = status.batasSuhu;
          final statusPendingin = status.statusPendingin;

          _controller.value = statusPendingin == 0 ? false : true;

          if (idSuhu != null) {
            _firebaseService.getLatestSuhu(idSuhu).listen((sensor) {
              if (sensor != null) {
                setState(() {
                  suhu = sensor.suhu;
                  kelembaban = sensor.kelembaban.toInt();

                  if (kelembaban < 30) {
                    desKelembaban = "Kering";
                  } else if (kelembaban >= 30 && kelembaban <= 70) {
                    desKelembaban = "Sedang";
                  } else {
                    desKelembaban = "Lembab";
                  }
                });
              }
            });
          }
        });
      }
    });
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
            child: Row(
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
                        '$suhu°C',
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
                        '$kelembaban %',
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
                Card(
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
                      side: BorderSide(color: Colors.black.withOpacity(0.2)),
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
