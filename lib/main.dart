import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orchitech/pages/editAkun_page.dart';
import 'package:orchitech/pages/editPassword_page.dart';
import 'package:orchitech/pages/main_page.dart';
import 'package:orchitech/pages/riwayat_pendingin.dart';
import 'package:orchitech/pages/riwayat_penyiraman.dart';
import 'screen/homepage.dart'; // Ganti dengan halaman utama aplikasi
import 'screen/penyiraman_screen.dart';
import 'screen/suhu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        Penyiraman.routeName: (context) => Penyiraman(),
        ScreenSuhu.routeName: (context) => ScreenSuhu(),
        RiwayatPenyiraman.routeName: (context) => RiwayatPenyiraman(),
        RiwayatPendingin.routeName: (context) => RiwayatPendingin(),
        EditAkunPage.routeName: (context) => EditAkunPage(),
        GantiPasswordPage.routeName: (context) => GantiPasswordPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}