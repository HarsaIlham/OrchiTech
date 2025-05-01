import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: const [
          FirstOnboarding(),
          SecondOnboarding(),
        ],
      ),
    );
  }
}

/// Halaman onboarding 1
class FirstOnboarding extends StatelessWidget {
  const FirstOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CurvedTopClipper(),
              child: Container(
                height: 650,
                color: const Color(0xFF1C7C56),
              ),
            ),
            Positioned.fill(
              top: 150,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/onboarding1.png',
                  height: 500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(
                'Selamat Datang di OrchiTech',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C7C56),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Rawat anggrek jadi lebih mudah! Pantau dan kontrol kondisi tanaman secara otomatis langsung dari genggamanmu.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, size: 10, color: Colors.green),
            SizedBox(width: 6),
            Icon(Icons.circle_outlined, size: 10, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: CircleAvatar(
              backgroundColor: Color(0xFF1C7C56),
              child: IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () {
                  // Akses ke controller lewat context
                  final state = context.findAncestorStateOfType<_OnboardingPageState>();
                  state?._nextPage();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Halaman onboarding 2
class SecondOnboarding extends StatelessWidget {
  const SecondOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CurvedTopClipper(),
              child: Container(
                height: 650,
                color: const Color(0xFF1C7C56),
              ),
            ),
            Positioned.fill(
              top: 150,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/onboarding1.png',
                  height: 500,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(
                'Siap Merawat Anggrek Lebih Mudah?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C7C56),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Ciptakan lingkungan tumbuh yang ideal dengan sistem otomatis yang memastikan anggrekmu tetap segar dan terawat setiap saat.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle_outlined, size: 10, color: Colors.grey),
                  SizedBox(width: 6),
                  Icon(Icons.circle, size: 10, color: Colors.green),
                ],
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1C7C56),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onPressed: () {
                    // Arahkan ke halaman berikutnya (misal login / home)
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16,
                    color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: 'Sudah punya akun? ',
                  children: [
                    TextSpan(
                      text: 'Masuk',
                      style: TextStyle(
                        color: Color(0xFF1C7C56),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// CustomClipper untuk background gelombang
class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
