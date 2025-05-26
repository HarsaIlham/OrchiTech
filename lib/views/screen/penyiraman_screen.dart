import 'package:flutter/material.dart';
import 'package:orchitech/controllers/status_penyiraman_controller.dart';
import 'package:orchitech/provider/status_penyiraman_provider.dart';
import 'package:provider/provider.dart';
import '../pages/jadwal_penyiraman.dart';
import '../pages/riwayat_penyiraman.dart';
import '/widget/appbar.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class Penyiraman extends StatefulWidget {
  const Penyiraman({super.key});
  static const routeName = '/penyiramanscreen';

  @override
  State<Penyiraman> createState() => _PenyiramanState();
}

class _PenyiramanState extends State<Penyiraman> {
  final _statusController = StatusPenyiramanController();
  final _controller = ValueNotifier<bool>(false);
  final _controller1 = ValueNotifier<bool>(false);
  bool _checked = false;
  bool _isTapped = false;
  bool _updateBySistem1 = false;
  bool _updateBySistem2 = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<StatusPenyiramanProvider>();
      _controller.value = provider.status1;
      _controller1.value = provider.status2; // Inisialisasi awal

      provider.addListener(() {
        if (_controller.value != provider.status1) {
          _updateBySistem1 = true;
          _controller.value = provider.status1;
        }
        if (_controller1.value != provider.status2) {
          _updateBySistem2 = true;
          _controller1.value = provider.status2;
        }
      });
    });

    _controller.addListener(() {
      if (_updateBySistem1) {
        _updateBySistem1 = false;
        return;
      }
      print("UPDATE 1 BY USER = ${_controller.value}");
      _statusController.editStatusPenyiraman(_controller.value, 1);
    });

    _controller1.addListener(() {
      if (_updateBySistem2) {
        _updateBySistem2 = false;
        return;
      }
      print("UPDATE 1 BY USER = ${_controller1.value}");
      _statusController.editStatusPenyiraman(_controller1.value, 2);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Penyiraman',
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Jalur Penyiraman 1',
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
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Jalur Penyiraman 2',
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
                  controller: _controller1,
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
                  'Atur Jadwal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Jalur Penyiraman 1',
                  style: TextStyle(fontSize: 14),
                ),
                contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
                ),
                tileColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const JadwalPenyiraman(idJalur: 1),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Atur Jadwal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'Jalur Penyiraman 2',
                  style: TextStyle(fontSize: 14),
                ),
                contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
                ),
                tileColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const JadwalPenyiraman(idJalur: 2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Riwayat Penyiraman',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _isTapped ? Colors.white : Colors.black,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
                ),
                tileColor: _isTapped ? Color(0xFF1C7C56) : Colors.white,
                onTap: () {
                  Navigator.of(context).pushNamed(RiwayatPenyiraman.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
