// lib/pages/welcome_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Welcome',
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome,",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "DaNang",
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, size: 30),
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Saved Places",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _imageCard('assets/h1.jpg'),
                  _imageCard('assets/h2.jpg'),
                  _imageCard('assets/h3.jpg'),
                  _imageCard('assets/h4.jpg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageCard(String path) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.asset(path, fit: BoxFit.cover),
  );
}
