import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/checkout_controller.dart';
import 'package:shopfinity/model/order_model.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/shared/widgets/custom_alert.dart';
import 'package:shopfinity/shared/widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  CheckoutController checkoutController = Get.put(CheckoutController());
  List<OrderModel> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<OrderModel> loadedOrders =
          await checkoutController.getOrdersFromPreferences();
      // Sort orders by date (newest first)
      loadedOrders.sort((a, b) {
        if (a.orderDate == null && b.orderDate == null) return 0;
        if (a.orderDate == null) return 1;
        if (b.orderDate == null) return -1;
        return DateTime.parse(b.orderDate!)
            .compareTo(DateTime.parse(a.orderDate!));
      });

      setState(() {
        orders = loadedOrders;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      await showCustomAlert(
          title: 'Error', message: 'Failed to load orders: $e', isError: true);
    }
  }

  Future<void> _refreshOrders() async {
    await _loadOrders();
  }

  void _showOrderDetails(OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),

            // Order details content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection('Order Information', [
                      _buildDetailRow('Order ID', order.orderId ?? 'N/A'),
                      _buildDetailRow(
                          'Date',
                          order.orderDate != null
                              ? _formatDetailDate(order.orderDate!)
                              : 'N/A'),
                      _buildDetailRow('Customer', order.customerName ?? 'N/A'),
                      _buildDetailRow('Total Amount',
                          '\$${order.price?.toStringAsFixed(2) ?? '0.00'}'),
                      _buildDetailRow(
                          'Items Count', '${order.products.length}'),
                      _buildDetailRow(
                          'Delivery Status', order.deliveryStatus ?? 'Pending'),
                      _buildDetailRow(
                          'Payment Status', order.paymentStatus ?? 'Pending'),
                    ]),
                    const SizedBox(height: 20),
                    if (order.products.isNotEmpty)
                      _buildDetailSection(
                          'Items Ordered',
                          order.products
                              .map((product) => _buildProductRow(product))
                              .toList()),
                    const SizedBox(height: 20),
                    if (order.address != null && order.address!.isNotEmpty)
                      _buildDetailSection('Delivery Address', [
                        _buildDetailRow('Address', order.address ?? ''),
                        if (order.apt != null && order.apt!.isNotEmpty)
                          _buildDetailRow('Apartment', order.apt!),
                        _buildDetailRow('City', order.city ?? ''),
                        if (order.district != null &&
                            order.district!.isNotEmpty)
                          _buildDetailRow('District', order.district!),
                        _buildDetailRow('State', order.state ?? ''),
                        _buildDetailRow('Postal Code', order.postalCode ?? ''),
                        _buildDetailRow('Country', order.country ?? ''),
                      ]),
                    const SizedBox(height: 20),
                    if (order.nameOnCard != null &&
                        order.nameOnCard!.isNotEmpty)
                      _buildDetailSection('Payment Information', [
                        _buildDetailRow('Name on Card', order.nameOnCard ?? ''),
                        _buildDetailRow(
                            'Card Number', order.cardNumber ?? '****'),
                        _buildDetailRow('Expiry Date', order.expiryDate ?? ''),
                      ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          if (product.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                product.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDetailDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Orders')),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'clear_all') {
                _showClearAllConfirmation();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Clear All Orders'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshOrders,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : orders.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No orders found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your orders will appear here after checkout',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showOrderDetails(orders[index]),
                          child: OrderCard(order: orders[index]),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  void _showClearAllConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Orders'),
        content: const Text(
            'Are you sure you want to clear all orders? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await checkoutController.clearAllOrders();
              await _loadOrders();
              await showCustomAlert(
                  title: 'Success', message: 'All orders cleared successfully');
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
