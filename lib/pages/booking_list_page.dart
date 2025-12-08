// lib/pages/booking_list_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';

class Place {
  final String imagePath;
  final String name;
  final String rating;
  final String review;
  final String distance;
  final String roomType;
  final String price;
  final String note1;
  final String note2;
  final String tag;
  final bool isManagedByHost;

  const Place({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.review,
    required this.distance,
    required this.roomType,
    required this.price,
    required this.note1,
    required this.note2,
    required this.tag,
    this.isManagedByHost = false,
  });
}

final List<Place> savedPlaces = const [
  Place(
    imagePath: 'assets/n1.jpg',
    name: 'aNhill Boutique',
    rating: '9.5',
    review: 'Xuất sắc · 95 đánh giá',
    distance: 'Huế · Cách bạn 0,6km',
    roomType: '1 suite riêng tư: 1 giường',
    price: 'US\$109',
    note1: 'Đã bao gồm thuế và phí',
    note2: '',
    tag: 'Bao bữa sáng',
  ),
  Place(
    imagePath: 'assets/n2.jpg',
    name: 'An Nam Hue Boutique',
    rating: '9.2',
    review: 'Tuyệt hảo · 34 đánh giá',
    distance: 'Cư Chính · Cách bạn 0,9km',
    roomType: '1 phòng khách sạn: 1 giường',
    price: 'US\$20',
    note1: 'Đã bao gồm thuế và phí',
    note2: '',
    tag: 'Bao bữa sáng',
  ),
  Place(
    imagePath: 'assets/n3.jpg',
    name: 'Huế Jade Hill Villa',
    rating: '8.0',
    review: 'Rất tốt · 1 đánh giá',
    distance: 'Cư Chính · Cách bạn 1,3km',
    roomType:
        '1 biệt thự nguyên căn – 1.000 m²:\n4 giường · 3 phòng ngủ · 1 phòng khách · 3 phòng tắm',
    price: 'US\$285',
    note1: 'Đã bao gồm thuế và phí',
    note2:
        'Chỉ còn 1 căn với giá này trên Booking.com\nKhông cần thanh toán trước',
    tag: '',
    isManagedByHost: true,
  ),
  Place(
    imagePath: 'assets/n1.jpg',
    name: 'Êm Villa',
    rating: '9.0',
    review: 'Tuyệt hảo · 12 đánh giá',
    distance: 'Huế · Cách bạn 1,1km',
    roomType: '1 villa riêng tư: 1 giường đôi lớn',
    price: 'US\$60',
    note1: 'Đã bao gồm thuế và phí',
    note2: '',
    tag: 'Bao bữa sáng',
    isManagedByHost: true,
  ),
];

class BookingListPage extends StatelessWidget {
  const BookingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Khách sạn tại Huế',
      body: Column(
        children: [
          // THANH CÔNG CỤ – GIẢM KHOẢNG TRẮNG
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 3), // giảm padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _toolButton(Icons.sort, 'Sắp xếp', true),
                _toolButton(Icons.tune, 'Lọc'),
                _toolButton(Icons.map_outlined, 'Bản đồ'),
              ],
            ),
          ),

          // SỐ LƯỢNG – GIẢM KHOẢNG TRẮNG
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              '${savedPlaces.length} chỗ nghỉ',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          // DANH SÁCH
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: savedPlaces.length,
              itemBuilder: (context, i) => PlaceCard(place: savedPlaces[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolButton(IconData icon, String label, [bool dot = false]) {
    return Column(
      children: [
        Stack(
          children: [
            Icon(icon, size: 26),
            if (dot)
              const Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// PlaceCard giữ nguyên đẹp như cũ
class PlaceCard extends StatelessWidget {
  final Place place;
  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        children: [
          Image.asset(
            place.imagePath,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.green,
                      child: Text(
                        place.rating,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(place.review, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                Text(
                  place.distance,
                  style: const TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(place.roomType, style: const TextStyle(fontSize: 12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          place.price,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          place.note1,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
