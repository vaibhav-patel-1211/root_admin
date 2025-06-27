import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:root_admin/component/product_grid_tile.dart';
import 'package:root_admin/component/secondary_product_tile.dart';
import 'package:root_admin/constants.dart';
import 'add_product_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool _isGridView = true;
  String _searchQuery = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? _productsStream;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _productsStream = _firestore
          .collection('products')
          .where('adminId', isEqualTo: currentUser.uid)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            // icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            icon: SvgPicture.asset(_isGridView
                ? 'assets/icons/list.svg'
                : 'assets/icons/grid.svg'),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(
                  Icons.search,
                  size: 28,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data?.docs
                        .map((doc) => doc.data() as Map<String, dynamic>)
                        .where((product) =>
                            _searchQuery.isEmpty ||
                            product['name']
                                .toString()
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            product['brand']
                                .toString()
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                        .toList() ??
                    [];

                if (products.isEmpty) {
                  return SvgPicture.asset(
                    'assets/icons/empty.svg',
                    height: 24,
                  );
                }

                return _isGridView
                    ? _buildGridView(products)
                    : _buildListView(products);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductGridTile(
          image: (product['images'] as List<dynamic>).first.toString(),
          title: product['name'],
          brandName: product['brand'],
          price: product['price'],
          press: () {
            // TODO: Navigate to product details
          },
        );
      },
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 5),
          child: SecondaryProductCard(
            brandName: product['brand'],
            image: (product['images'] as List<dynamic>).first.toString(),
            title: product['name'],
            price: product['price'],
            press: () {},
          ),
        );
      },
    );
  }
}
