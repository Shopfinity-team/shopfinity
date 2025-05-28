import 'package:get/get.dart';
import 'package:shopfinity/controllers/profile_controller.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/services/cart_service.dart';

class CartController extends GetxController{
  var cartItems = <Product>[].obs;
  var cartItemCount = 0.obs;
  var totalPrice = 0.0.obs;
  int? cartId;

  CartService cartService = CartService();
  ProfileController profileController = Get.put(ProfileController());

  late String userId;

  Future<void> syncWithServer(String userId) async{
    try {
      var data = await cartService.getCartItemsCount(userId);
      if (data['total'] == 0) {
        print("No cart data found for user: $userId");
        return;
      }
      else {
        cartId = data['carts'][0]['id'];
        cartItemCount.value = data['carts'][0]['totalProducts'];
        cartItems.value = (data['carts'][0]['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
    } catch (e) {
      print("Error syncing with server: $e");
    }
  }

  Future<void> initializeCartForUser(String userId) async {
    this.userId = userId;
    await syncWithServer(userId);
    if (cartId == null || cartId == 0) {
      await createCart(userId, cartItems);
    }
  }

  Future<void> createCart(String userId, List<Product> products) async {
    try {
      cartId = await cartService.addToCart(userId, products);
      if (cartId != 0) {
        print("Products added to cart with ID: $cartId");
      } else {
        print("Failed to add products to cart");
      }
    } catch (e) {
      print("Error adding to cart on server: $e");
    }
  }

  Future<void> addToCart(Product product) async {
    if (cartItems.contains(product)) {
      var index = cartItems.indexOf(product);
      cartItems[index].quantity.value += 1;
      totalPrice.value += product.price;
    } else {
      product.quantity = 1.obs;
      cartItems.add(product);
      totalPrice.value += product.price;
    }
    cartItemCount.value = cartItems.length;
    await cartService.updateCart(cartId, product.id!, product.quantity.value);
  }

  Future<void> removeFromCart(Product product) async {
    if (cartItems.contains(product)) {
      cartItems.remove(product);
      totalPrice.value -= product.price * product.quantity.value;
      cartItemCount.value = cartItems.length;
      await cartService.updateCart(cartId, product.id!, 0);
    }
  }

  Future<void> clearCart() async{
    try {
      await cartService.removeCart(cartId, 0);
      cartItems.clear();
      totalPrice.value = 0.0;
      cartItemCount.value = 0;
    } catch (e) {
      print("Error clearing cart: $e");
    }
  }

  void increaseQuantity(Product product) async {
    final index = cartItems.indexOf(product);
    if (index != -1) {
      cartItems[index].quantity.value += 1;
      totalPrice.value += product.price;
      await cartService.updateCart(cartId, product.id!, cartItems[index].quantity.value);
    }
  }

  void decreaseQuantity(Product product) async {
    final index = cartItems.indexOf(product);
    if (index != -1 && cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value -= 1;
      totalPrice.value -= product.price;
      await cartService.updateCart(cartId, product.id!, cartItems[index].quantity.value);
    }
    else if (index != -1 && cartItems[index].quantity.value == 1) {
      await removeFromCart(product);
    }
  }

}