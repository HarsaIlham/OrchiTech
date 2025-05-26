import 'package:flutter/material.dart';
import 'package:orchitech/views/screen/homepage.dart';
import '../screen/profil_screen.dart';
import '../screen/penyiraman_screen.dart';
import '../screen/suhu_screen.dart';
import '../../widget/navbar.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});
  static const String routeName = '/mainpage';

  @override
  State<MainPage> createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    HomePage(), 
    Penyiraman(), 
    SuhuScreen(),
    ProfilScreen(),];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
