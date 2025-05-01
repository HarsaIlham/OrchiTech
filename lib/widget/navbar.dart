import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  Widget _buildIcon(IconData icon, int index) {
    bool isActive = currentIndex == index;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1C7C56).withAlpha(25) : Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: isActive ? const Color(0xFF1C7C56) : Colors.grey,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues( 
              alpha: 0.5,
            ),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),

        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.water, 1),
              label: 'Penyiraman',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.thermostat, 2),
              label: 'Pengaturan',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person, 3), 
              label: 'Profil'),
          ],
          selectedItemColor: const Color(0xFF1C7C56),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          selectedIconTheme: const IconThemeData(color: Color(0xFF1C7C56)),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedLabelStyle: const TextStyle(color: Color(0xFF1C7C56)),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          iconSize: 30,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
