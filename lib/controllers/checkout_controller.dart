import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/controllers/delivery_controller.dart';
import 'package:shopfinity/controllers/payment_controller.dart';
import 'package:shopfinity/controllers/profile_controller.dart';
import 'package:shopfinity/model/order_model.dart';
import 'package:shopfinity/shared/widgets/custom_alert.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;
  var country = ''.obs;
  var address = ''.obs;
  var apt = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var postalCode = ''.obs;
  var deliveryStatus = 'Pending'.obs;
  var paymentStatus = 'Pending'.obs;
  var nameOnCard = ''.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cvv = ''.obs;

  final CartController cartController = Get.find();
  final ProfileController profileController = Get.find();
  final PaymentController paymentController = Get.put(PaymentController());
  final DeliveryController deliveryController = Get.put(DeliveryController());

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  // Generate unique order ID
  String _generateOrderId() {
    return 'ORD_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Calculate total quantity from cart items
  int _calculateTotalQuantity() {
    return cartController.cartItems
        .fold(0, (sum, item) => sum + (item.quantity.value));
  }

  // Save order to shared preferences
  Future<void> _saveOrderToPreferences(OrderModel order) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    // Get existing orders
    List<OrderModel> existingOrders = await getOrdersFromPreferences();

    // Add new order to the list
    existingOrders.add(order);

    // Convert orders to JSON and save
    List<Map<String, dynamic>> ordersJson =
        existingOrders.map((order) => order.toJson()).toList();
    await sharedPrefs.setString('saved_orders', jsonEncode(ordersJson));
  }

  // Get orders from shared preferences
  Future<List<OrderModel>> getOrdersFromPreferences() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? ordersString = sharedPrefs.getString('saved_orders');

    if (ordersString == null || ordersString.isEmpty) {
      return [];
    }

    try {
      List<dynamic> ordersJson = jsonDecode(ordersString);
      return ordersJson.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      print('Error parsing saved orders: $e');
      return [];
    }
  }

  // Clear all saved orders
  Future<void> clearAllOrders() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove('saved_orders');
  }

  Future<void> processCheckout() async {
    toggleLoading();
    try {
      final sharedPrefs = await SharedPreferences.getInstance();

      // Load address details
      country.value = sharedPrefs.getString('country') ?? '';
      address.value = sharedPrefs.getString('address') ?? '';
      apt.value = sharedPrefs.getString('apt') ?? '';
      district.value = sharedPrefs.getString('district') ?? '';
      city.value = sharedPrefs.getString('city') ?? '';
      state.value = sharedPrefs.getString('state') ?? '';
      postalCode.value = sharedPrefs.getString('postalCode') ?? '';

      if ([country, address, city, state, postalCode]
          .any((element) => element.value.isEmpty)) {
        await showCustomAlert(
            title: 'Error',
            message: 'Please complete your delivery address before proceeding.',
            isError: true);

        return;
      }

      // Load payment details
      nameOnCard.value = sharedPrefs.getString('nameOnCard') ?? '';
      cardNumber.value = sharedPrefs.getString('cardNumber') ?? '';
      expiryDate.value = sharedPrefs.getString('expiryDate') ?? '';
      cvv.value = sharedPrefs.getString('cvv') ?? '';

      if ([nameOnCard, cardNumber, expiryDate, cvv]
          .any((element) => element.value.isEmpty)) {
        await showCustomAlert(
            title: 'Error',
            message: 'Please complete your payment details before proceeding.',
            isError: true);

        return;
      }

      // Create OrderModel instance
      OrderModel newOrder = OrderModel(
        orderId: _generateOrderId(),
        customerName: profileController.userName.value.isNotEmpty
            ? profileController.userName.value
            : nameOnCard.value,
        products: List.from(cartController.cartItems),
        quantity: _calculateTotalQuantity(),
        price: cartController.totalPrice.value,
        orderDate: DateTime.now().toIso8601String(),

        // Address details
        country: country.value,
        address: address.value,
        apt: apt.value,
        district: district.value,
        city: city.value,
        state: state.value,
        postalCode: postalCode.value,

        // Payment details
        nameOnCard: nameOnCard.value,
        cardNumber: cardNumber.value.replaceRange(
            4,
            cardNumber.value.length - 4,
            '*' *
                (cardNumber.value.length - 8)), // Mask card number for security
        expiryDate: expiryDate.value,
        cvv: '***', // Never save actual CVV

        // Order status
        deliveryStatus: deliveryStatus.value,
        paymentStatus: paymentStatus.value,
      );

      // Save order using OrderModel
      await _saveOrderToPreferences(newOrder);

      // Keep the original orderDetails for backward compatibility if needed
      final orderDetails = {
        'orderId': newOrder.orderId,
        'country': country.value,
        'address': address.value,
        'city': city.value,
        'apt': apt.value,
        'district': district.value,
        'state': state.value,
        'postalCode': postalCode.value,
        'nameOnCard': nameOnCard.value,
        'cardNumber': cardNumber.value,
        'expiryDate': expiryDate.value,
        'cvv': cvv.value,
        'cartItems':
            cartController.cartItems.map((item) => item.toJson()).toList(),
        'totalPrice': cartController.totalPrice.value,
        'orderDate': newOrder.orderDate,
      };

      await sharedPrefs.setString('orderDetails', jsonEncode(orderDetails));

      // Clean up temporary data
      final keys = sharedPrefs.getKeys();
      for (var key in keys) {
        if (key != 'orderDetails' &&
            key != 'saved_orders' &&
            key != 'access_token' &&
            key != 'refresh_token') {
          await sharedPrefs.remove(key);
        }
      }

      await showCustomAlert(
          title: 'Success',
          message: 'Order placed successfully! Order ID: ${newOrder.orderId}');

      cartController.clearCart;
      Get.toNamed('/navbar');
    } catch (e) {
      await showCustomAlert(
          title: 'Error',
          message: 'Failed to complete checkout: $e',
          isError: true);

      print('Checkout error: $e');
    } finally {
      toggleLoading();
    }
  }

  // Get order by ID
  Future<OrderModel?> getOrderById(String orderId) async {
    List<OrderModel> orders = await getOrdersFromPreferences();
    try {
      return orders.firstWhere((order) => order.orderId == orderId);
    } catch (e) {
      return null;
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId,
      {String? deliveryStatus, String? paymentStatus}) async {
    List<OrderModel> orders = await getOrdersFromPreferences();

    for (int i = 0; i < orders.length; i++) {
      if (orders[i].orderId == orderId) {
        if (deliveryStatus != null) {
          orders[i].deliveryStatus = deliveryStatus;
        }
        if (paymentStatus != null) {
          orders[i].paymentStatus = paymentStatus;
        }
        break;
      }
    }

    // Save updated orders
    final sharedPrefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> ordersJson =
        orders.map((order) => order.toJson()).toList();
    await sharedPrefs.setString('saved_orders', jsonEncode(ordersJson));
  }
}
