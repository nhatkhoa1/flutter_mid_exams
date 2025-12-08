// lib/pages/dummy_store_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import '../services/api_dummy.dart';
import '../models/dummy_product.dart';
import '../screens/detail_dummy_screen.dart';

class DummyStorePage extends StatefulWidget {
  const DummyStorePage({super.key});
  @override
  State<DummyStorePage> createState() => _DummyStorePageState();
}

class _DummyStorePageState extends State<DummyStorePage> {
  late Future<ApiResponse> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = dummy_api.getAllProducts();
  }

  Future<void> _refresh() async {
    setState(() => futureProducts = dummy_api.getAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'DummyJSON Store',
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<ApiResponse>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!.products;
              return GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  final p = products[i];
                  final discounted = p.price * (1 - p.discountPercentage / 100);
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailDummyScreen(productId: p.id),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              p.thumbnail,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  p.brand,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      '\$${p.price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '\$${discounted.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 214, 41, 38),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            DetailDummyScreen(productId: p.id),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      size: 16,
                                    ),
                                    label: const Text(
                                      'Xem chi tiết',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        23,
                                        166,
                                        171,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
