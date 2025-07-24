import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final double _minPrice = 0;
  final double _maxPrice = 1000;
  RangeValues _currentRange = const RangeValues(200, 800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        title: const Text('Search Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter product name',
                      border: const OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search, color: Colors.blue[600]),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:Icon(Icons.filter_list, color: Colors.white)
                ),
              ],
            ),
            
            const SizedBox(height: 20),

           GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // 1 item per row
                mainAxisSpacing: 16,
                childAspectRatio: 1.8, // Adjust based on your layout needs
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ProductCard(
                  productName: 'Derby Leather Shoes',
                  category: 'Mens shoes',
                  price: '\$120',
                  brand: 'Merks shoes',
                  rating: '(6.0)',
                );
              },
            ),

            const SizedBox(height: 8),

            // Category Filter
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                hintText: 'Enter category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Price Filter
            

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                RangeSlider(
                  values: _currentRange,
                  min: _minPrice,
                  max: _maxPrice,
                  divisions: 100,
                  labels: RangeLabels(
                    'ETB ${_currentRange.start.round()}',
                    'ETB ${_currentRange.end.round()}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRange = values;
                    });
                  },
                  activeColor: Colors.blue[600],
                  inactiveColor: Colors.grey.shade300,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Apply filters functionality
                },
                child: const Text('APPLY'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String category;
  final String price;
  final String brand;
  final String rating;

  const ProductCard({
    super.key,
    required this.productName,
    required this.category,
    required this.price,
    required this.brand,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge, // Ensures children are clipped to the border radius
              child: Image.asset(
                'assets/images/image.png',
                fit: BoxFit.cover, // Fill the container
                width: double.infinity, // Take full width
                height: double.infinity, // Take full height
              ),
            ),
            const SizedBox(height: 12),
            

            // Product Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 8),

                // Price
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 4),

            // Price and Brand
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}