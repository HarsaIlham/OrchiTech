import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:orchitech/provider/status_pendingin_provider.dart';
import 'package:orchitech/provider/status_penyiraman_provider.dart';
import 'package:orchitech/services/mqtt_services.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:orchitech/views/pages/editPassword_page.dart';
import 'package:orchitech/views/pages/login_page.dart';
import 'package:orchitech/views/pages/main_page.dart';
import 'package:orchitech/views/pages/riwayat_pendingin.dart';
import 'package:orchitech/views/pages/riwayat_penyiraman.dart';
import 'package:orchitech/views/screen/splashscreen.dart';
import 'package:provider/provider.dart';
import 'views/screen/homepage.dart'; // Ganti dengan halaman utama aplikasi
import 'views/screen/penyiraman_screen.dart';
import 'views/screen/suhu_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://lyxsovhvhalnlxizeqyc.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5eHNvdmh2aGFsbmx4aXplcXljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUwMzU4MTIsImV4cCI6MjA2MDYxMTgxMn0.RPOlZz58zP_UaYqSO5fOaSl_Iu99pZwNmFEQ5ODWafs",
  );
  await initializeDateFormatting('id_ID', null);
  await MqttService().connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StatusPendinginProvider()),
        ChangeNotifierProvider(create: (_) => StatusPenyiramanProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        Penyiraman.routeName: (context) => Penyiraman(),
        ScreenSuhu.routeName: (context) => ScreenSuhu(),
        RiwayatPenyiraman.routeName: (context) => RiwayatPenyiraman(),
        RiwayatPendingin.routeName: (context) => RiwayatPendingin(),
        GantiPasswordPage.routeName: (context) => GantiPasswordPage(),
        LoginPage.routeName: (context) => LoginPage(),
        MainPage.routeName: (context) => MainPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
