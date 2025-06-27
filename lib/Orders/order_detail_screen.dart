import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late DocumentReference orderRef;
  final currentUser = FirebaseAuth.instance.currentUser;
  Set<String> _updatingFields = {};

  @override
  void initState() {
    super.initState();
    orderRef =
        FirebaseFirestore.instance.collection('orders').doc(widget.orderId);
  }

  Future<void> updateStatus(String field, String value) async {
    setState(() {
      _updatingFields.add(field);
    });
    await orderRef.update({field: value});
    setState(() {
      _updatingFields.remove(field);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: orderRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
          final productData = data['productData'] ?? {};
          final shippingAddress = data['shippingAddress'] ?? {};
          final List<dynamic> imageUrls = productData['imageUrls'] ?? [];
          final String? imageUrl =
              imageUrls.isNotEmpty ? imageUrls.first as String : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Product Image
                if (imageUrl != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                _sectionTitle("Product Info"),
                _infoCard([
                  _infoRow("Title", productData['title']),
                  _infoRow("Price", "₹${productData['price']}"),
                  _infoRow("Quantity", productData['quantity'].toString()),
                ]),

                _sectionTitle("Order Info"),
                _infoCard([
                  _infoRow("Order ID", data['orderId'] ?? widget.orderId),
                  _infoRow("Order Date", data['orderDate']),
                  _infoRow("Payment", data['paymentMethod']),
                  _infoRow("User ID", data['userId']),
                ]),

                _sectionTitle("Shipping Address"),
                _infoCard([
                  _infoRow("Name", shippingAddress['fullName']),
                  _infoRow("Phone", shippingAddress['phoneNumber']),
                  _infoRow("Street", shippingAddress['streetAddress']),
                  _infoRow("City", shippingAddress['city']),
                  _infoRow("State", shippingAddress['state']),
                  _infoRow("ZIP", shippingAddress['zipCode']),
                ]),

                _sectionTitle("Order Status"),
                _statusCard([
                  _buildStatusSwitch(
                    label: 'Processed',
                    field: 'status_order_processed',
                    value: data['status_order_processed'] == 'true',
                  ),
                  _buildStatusSwitch(
                    label: 'Shipped',
                    field: 'status_order_shipped',
                    value: data['status_order_shipped'] == 'true',
                  ),
                  _buildStatusSwitch(
                    label: 'Delivered',
                    field: 'status_order_delivered',
                    value: data['status_order_delivered'] == 'true',
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _infoRow(String label, dynamic value) {
    String displayValue;
    if (value == null) {
      displayValue = '-';
    } else if (value is Timestamp) {
      final date = value.toDate();
      displayValue =
          "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
    } else {
      displayValue = value.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(child: Text(displayValue, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _statusCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildStatusSwitch({
    required String label,
    required String field,
    required bool value,
  }) {
    final isUpdating = _updatingFields.contains(field);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: isUpdating
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Switch(
              value: value,
              onChanged: value
                  ? null
                  : (newValue) async {
                      if (newValue) {
                        await updateStatus(field, 'true');
                      }
                    },
            ),
    );
  }
}
