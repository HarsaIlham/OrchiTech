import 'package:flutter/material.dart';
import '../service.dart';
import '../pages/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  String desKelembaban = "";
  String desStatus = "";
  int batassuhu = 0;
  double suhu = 0;
  int kelembaban = 0;

  @override
  void initState() {
    super.initState();
    getLatestData();
  }

  void getLatestData() async {
    _firebaseService.getLatestStatus().listen((status) {
      if (status != null) {
        setState(() {
          final idSuhu = status.idSuhu;
          batassuhu = status.batasSuhu;
          final statusPendingin = status.statusPendingin;
          if (statusPendingin == 0) {
            desStatus = "Off";
          } else {
            desStatus = "On";
          }

          if (idSuhu != null) {
            _firebaseService.getLatestSuhu(idSuhu).listen((sensor) {
              if (sensor != null) {
                setState(() {
                  suhu = sensor.suhu;
                  kelembaban = sensor.kelembaban.toInt();

                  if (kelembaban < 30) {
                    desKelembaban = "Kering";
                  } else if (kelembaban >= 30 && kelembaban <= 70) {
                    desKelembaban = "Sedang";
                  } else {
                    desKelembaban = "Lembab";
                  }
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(18, 126, 90, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_dashboard.png',
                        scale: 1.0,
                      ),
                      const Text(
                        'OrchiTech',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Welcome!',
                            style: TextStyle(
                              fontSize: 28,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Grown by Nature, Bloomed\nwith Care',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      // CARD SUHU
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(116, 169, 152, 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/icon_matahari.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Suhu : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '$suhu°',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Celcius',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/icon_humidity.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  Text(
                                    '$kelembaban%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                desKelembaban,
                                style: TextStyle(
                                  color: Color.fromRGBO(247, 206, 69, 1),
                                  fontSize: 12,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // BODY
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(34, 0, 16, 0),
            child: const Text(
              'Penyiraman',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(16, 95, 71, 1),
              ),
            ),
          ),

          // CARD
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: dashboardCard(
              image: 'assets/images/bg_Penyiraman.png',
              text4: 'Status:',
              text5: 'Off',
              img1: 'assets/images/icon_siram.png',
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(34, 0, 16, 0),
            child: const Text(
              'Suhu & Kelembaban',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(16, 95, 71, 1),
              ),
            ),
          ),

          //CARD
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: dashboardCard(
              image: 'assets/images/bg_status.png',
              text1: 'Batas Suhu:',
              text2: '$batassuhu°',
              text3: 'Celcius',
              text4: 'Status:',
              text5: desStatus,
              img1: 'assets/images/icon_matahari.png',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboardCard({
    required String image,
    String? text1,
    String? text2,
    String? text3,
    String? text4,
    String? text5,
    String? img1,
    required VoidCallback onPressed,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            image,
            height: 144,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 144,
            padding: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1 ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        text2 ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        text3 ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          height: 0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        text4 ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        text5 ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          height: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(img1 ?? '', height: 50, width: 50),
                      ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withValues(alpha: 0.2),
                        ),
                        child: Text(
                          'Detail',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
