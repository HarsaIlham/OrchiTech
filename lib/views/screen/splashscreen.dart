import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orchitech/views/pages/main_page.dart';
import '../pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    // Pindah ke onboarding setelah 3 detik
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final isLoggedIn = await _storage.read(key: 'user_email');
    if (isLoggedIn != null) {
      Navigator.pushReplacementNamed(context, MainPage.routeName);
      print(isLoggedIn);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
    // await _storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C7C56),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo_orchitech.png', height: 250),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'OrchiTech 1.0.0',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
