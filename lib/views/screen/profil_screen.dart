import 'package:flutter/material.dart';
import 'package:orchitech/controllers/akun_controller.dart';
import '../pages/editAkun_page.dart';
import '../pages/editPassword_page.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _akunController = AkunController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1C7C56),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: _akunController.fetchProfile(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          return Column(
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
                    data!.username,
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
                        data.email,
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
                        data.username,
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
                        Navigator.pushNamed(
                          context,
                          GantiPasswordPage.routeName,
                        );
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditAkunPage(email:data.email, username:data.username)));
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
                          Text(
                            'Edit Akun',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(child: Text('APAKAH ANDA YAKIN ?')),
                              content: Text('Apakah Anda yakin ingin Logout?'),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(
                                      214,
                                      29,
                                      32,
                                      1,
                                    ),
                                  ),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await _akunController.LogoutUser(context: context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
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
          );
        },
      ),
    );
  }
}
