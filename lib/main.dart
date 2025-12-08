// lib/main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/timer_page.dart';
import 'pages/travel_card_page.dart';
import 'pages/welcome_page.dart';
import 'pages/booking_list_page.dart';
import 'pages/fake_store_page.dart';
import 'pages/dummy_store_page.dart';
import 'pages/login_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  static const Color skyBlue = Color(0xFF87CEEB);

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool('isDarkMode', isDarkMode),
      );
    });
  }

  static void toggleGlobalTheme(BuildContext context) {
    final state = context.findAncestorStateOfType<MyAppState>();
    state?._toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lập trình Di Động - GV Nguyễn Dũng',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: skyBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: skyBlue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: skyBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: skyBlue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('studentId') == '22T1020175') {
      setState(() => isLoggedIn = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const HomePage() : const LoginPage();
  }
}

// Trong main.dart – thay class LoginPage
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => MyAppState.toggleGlobalTheme(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LoginForm(), // ← GỌI FILE MỚI Ở ĐÂY
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lập trình Di Động'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.black : Colors.white,
              size: 30,
            ),
            onPressed: () => MyAppState.toggleGlobalTheme(context),
          ),
          const SizedBox(width: 12),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: MyAppState.skyBlue),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: MyAppState.skyBlue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '22T1020175',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Phan Minh Nhật Khoa',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Bài giảng'),
              onTap: () {},
            ), // ← TRẢ LẠI NHƯ CŨ, CHƯA LÀM GÌ

            ExpansionTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Bài tập'),
              childrenPadding: const EdgeInsets.only(left: 16),
              children: [
                ListTile(
                  title: const Text('Bài 1 - Bộ đếm ngược'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TimerPage()),
                  ),
                ),
                ListTile(
                  title: const Text('Bài 2 - Travel Card UI'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TravelCardPage()),
                  ),
                ),
                ListTile(
                  title: const Text('Bài 3 - Welcome + Grid'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomePage()),
                  ),
                ),
                ListTile(
                  title: const Text('Bài 4 - Booking.com UI'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookingListPage()),
                  ),
                ),
                ListTile(
                  title: const Text('Bài 5 - Fake Store App'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FakeStorePage()),
                  ),
                ),
                ListTile(
                  title: const Text('Bài 6 - DummyJSON Store'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DummyStorePage()),
                  ),
                ),
              ],
            ),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Đăng xuất'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('studentId');
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 120, color: MyAppState.skyBlue),
            SizedBox(height: 30),
            Text(
              'Học phần\nLập trình Di Động',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Giảng viên: Nguyễn Dũng', style: TextStyle(fontSize: 26)),
          ],
        ),
      ),
    );
  }
}
