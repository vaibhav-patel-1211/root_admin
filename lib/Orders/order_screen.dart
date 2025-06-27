import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? adminId = FirebaseAuth.instance.currentUser?.uid;

    if (adminId == null) {
      return const Center(child: Text('Not logged in as admin.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('productData.adminId', isEqualTo: adminId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final orders = snapshot.data?.docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final status = data['status_order_delivered'];
                return status == 'false' || status == false;
              }).toList() ??
              [];
          if (orders.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;
              final productData = order['productData'] ?? {};
              final shippingAddress = order['shippingAddress'] ?? {};
              final List<dynamic> imageUrls = productData['imageUrls'] ?? [];
              final String? imageUrl =
                  imageUrls.isNotEmpty ? imageUrls.first as String : null;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: imageUrl != null
                      ? Image.network(imageUrl,
                          width: 60, height: 60, fit: BoxFit.cover)
                      : const Icon(Icons.image_not_supported),
                  title: Text(productData['title'] ?? 'No Title'),
                  subtitle: Text('Order ID: ${order['orderId'] ?? ''}\n'
                      'Customer: ${shippingAddress['fullName'] ?? ''}\n'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailScreen(orderId: orders[index].id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
