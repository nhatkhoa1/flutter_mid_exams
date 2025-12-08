// lib/pages/login_form.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // để dùng MyAppState.skyBlue và HomePage

class LoginForm extends StatelessWidget {
  final TextEditingController idController = TextEditingController(
    text: '22T1020175',
  );
  final TextEditingController passController = TextEditingController(
    text: 'Nhatkhoa,123',
  );

  LoginForm({super.key});

  void _login(BuildContext context) async {
    final id = idController.text.trim();
    final pass = passController.text.trim();

    if (id == '22T1020175' && pass == 'Nhatkhoa,123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('studentId', id);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } else {
      // Thông báo lỗi + bắt nhập lại
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sai mã sinh viên hoặc mật khẩu! Vui lòng nhập lại.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.school, size: 100, color: Colors.blue),
          const SizedBox(height: 30),
          const Text(
            'Học phần Lập trình Di Động',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text('Giảng viên: Nguyễn Dũng', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 50),
          TextField(
            controller: idController,
            decoration: const InputDecoration(
              labelText: 'Mã sinh viên',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Mật khẩu',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAppState.skyBlue,
              ),
              onPressed: () => _login(context),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
