// lib/pages/fake_store_page.dart
import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import '../services/api.dart';
import '../models/product.dart';

class FakeStorePage extends StatefulWidget {
  const FakeStorePage({super.key});

  @override
  State<FakeStorePage> createState() => _FakeStorePageState();
}

class _FakeStorePageState extends State<FakeStorePage> {
  late Future<List<Product>> futureProducts;
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String searchQuery = '';
  Set<String> categories = {};
  String selectedCategory = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    futureProducts = api.getAllProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      searchQuery = '';
      selectedCategory = 'Tất cả';
      _loadProducts();
    });
  }

  void _filterProducts(String query) {
    _applyFilters(query, selectedCategory);
  }

  void _selectCategory(String category) {
    setState(() => selectedCategory = category);
    _applyFilters(searchQuery, category);
  }

  void _applyFilters(String query, String category) {
    setState(() {
      searchQuery = query;
      filteredProducts = allProducts.where((p) {
        final matchesSearch =
            query.isEmpty ||
            p.title.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = category == 'Tất cả' || p.category == category;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 2; // Mobile
    if (width < 900) return 3; // Tablet
    return 4; // Desktop
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 0.65; // Mobile cao
    return 0.75; // Rộng hơn
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Fake Store App',
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<Product>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              allProducts = snapshot.data!;
              categories = {'Tất cả', ...allProducts.map((p) => p.category)};
              if (filteredProducts.isEmpty) filteredProducts = allProducts;

              return Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onChanged: _filterProducts,
                      decoration: InputDecoration(
                        hintText: 'Tìm theo tên hoặc loại...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => _filterProducts(''),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  // Categories
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        final cat = categories.elementAt(i);
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(cat),
                            selected: selectedCategory == cat,
                            onSelected: (selected) => _selectCategory(cat),
                            selectedColor: Colors.teal,
                            backgroundColor: Colors.grey[200],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Grid Sản phẩm
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(context),
                        childAspectRatio: _getChildAspectRatio(context),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, i) {
                        final p = filteredProducts[i];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    p.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      p.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              p.rate.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '(${p.count})',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '\$${p.price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Lỗi: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
