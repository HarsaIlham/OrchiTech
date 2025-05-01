import 'package:flutter/material.dart';
import 'package:orchitech/pages/editAkun_page.dart';
import 'package:orchitech/pages/editPassword_page.dart';
import 'package:orchitech/widget/appbar.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Profil',
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 237,
            decoration: BoxDecoration(
              color: Color(0xFF1C7C56),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset('assets/images/image_profil.png')],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Harsa Ilham',
                style: TextStyle(
                  color: Color.fromRGBO(3, 68, 45, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Text(
                    '@',
                    style: TextStyle(
                      color: Color.fromRGBO(3, 68, 45, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(
                    'HarsaIlham@mail.com',
                    style: TextStyle(
                      color: Color.fromRGBO(3, 68, 45, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black.withOpacity(0.2)),
                  ),
                  tileColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(height: 6),
                ListTile(
                  leading: Icon(
                    Icons.person_outline_rounded,
                    color: Color.fromRGBO(3, 68, 45, 1),
                    size: 26,
                  ),
                  title: Text(
                    'Harsa Ilham',
                    style: TextStyle(
                      color: Color.fromRGBO(3, 68, 45, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black.withOpacity(0.2)),
                  ),
                  tileColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(height: 12),
                ListTile(
                  leading: Icon(
                    Icons.lock_outline_rounded,
                    color: Color.fromRGBO(3, 68, 45, 1),
                    size: 26,
                  ),
                  title: Text(
                    'Ganti Password',
                    style: TextStyle(
                      color: Color.fromRGBO(3, 68, 45, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black.withOpacity(0.2)),
                  ),
                  tileColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {
                    Navigator.pushNamed(context, GantiPasswordPage.routeName);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(86, 0, 86, 0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditAkunPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(3, 68, 45, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Edit Akun', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(214, 29, 32, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Logout', style: TextStyle(color: Colors.white)),
                    ],
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
