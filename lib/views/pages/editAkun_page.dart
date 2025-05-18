import 'package:flutter/material.dart';

import '../../controllers/akun_controller.dart';
import '../../widget/appbar.dart';

class EditAkunPage extends StatefulWidget {
  const EditAkunPage({super.key, required this.email, required this.username});
  static const routeName = '/editakun';
  final String email;
  final String username;

  @override
  State<EditAkunPage> createState() => _EditAkunPageState();
}

@override
class _EditAkunPageState extends State<EditAkunPage> {
  final emailC = TextEditingController();
  final usernameC = TextEditingController();
  final _akunController = AkunController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailC.dispose();
    usernameC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailC.text = widget.email;
    usernameC.text = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        colorAnimated: ColorAnimated(
          background: Color(0xFF1C7C56),
          color: Colors.white,
        ),
        title: 'Edit Akun',
        icon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: usernameC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Username',
                    style: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  ),
                ),
              ),
              maxLength: 21,
            ),
            TextField(
              controller: emailC,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Email',
                    style: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  ),
                ),
              ),
              maxLength: 42,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(3, 68, 45, 1),
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: 150,
                    child:
                        _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                              'Simpan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(child: Text('APAKAH ANDA YAKIN ?')),
                          content: Text(
                            'Apakah Anda yakin ingin mengubah akun?',
                          ),
                          actions: [
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(3, 68, 45, 1),
                              ),
                              child: Text(
                                'Simpan',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                setState(() {
                                _isLoading = true;
                                });
                                await _akunController.updateUserProfile(
                                  username: usernameC.text,
                                  email: emailC.text,
                                  context: context,
                                );
                                setState(() {
                                _isLoading = false;
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();

                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
