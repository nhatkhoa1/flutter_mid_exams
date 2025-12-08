// lib/pages/travel_card_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';

class TravelCardPage extends StatelessWidget {
  const TravelCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Oeschinen Lake',
      body: ListView(
        children: [
          Image.network(
            "https://images.pexels.com/photos/34103332/pexels-photo-34103332.jpeg",
            height: 320,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "Oeschinen Lake Campground",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Kandersteg, Switzerland",
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _button(Icons.call, "CALL", Colors.blue),
              _button(Icons.near_me, "ROUTE", Colors.blue),
              _button(Icons.share, "SHARE", Colors.blue),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              "Hồ Oeschinen nằm dưới chân núi Blüemlisalp thuộc dãy Alps Bernese. Nằm ở độ cao 1.578 mét so với mực nước biển...",
              style: TextStyle(fontSize: 16, height: 1.7),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
