import 'package:flutter/material.dart';
import 'package:orchitech/pages/jadwal_penyiraman.dart';
import 'package:orchitech/pages/riwayat_penyiraman.dart';
import '/widget/appbar.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class Penyiraman extends StatefulWidget {
  const Penyiraman({super.key});
  static const routeName = '/penyiramanscreen';

  @override
  State<Penyiraman> createState() => _PenyiramanState();
}

class _PenyiramanState extends State<Penyiraman> {
  final _controller = ValueNotifier<bool>(false);
  final _controller1 = ValueNotifier<bool>(false);
  bool _checked = false;
  bool _isTapped = false;
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
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
