import 'package:get/get.dart';
import 'package:shopfinity/model/product_model.dart';

class CartController extends GetxController{
  var cartItems = <Product>[].obs;
  var cartItemCount = 0.obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    cartItems.listen((items) {
      cartItemCount.value = items.length;
    });
  }

  void addToCart(Product product) {
    cartItems.add(product);
    totalPrice.value += product.price * product.quantity.value;
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    totalPrice.value -= product.price * product.quantity.value ;
  }

  void clearCart() {
    cartItems.clear();
    totalPrice.value = 0.0;
  }

  void increaseQuantity(Product product, RxInt quantity) {
    var index = cartItems.indexOf(product);
    if (index != -1) {
      cartItems[index].quantity = quantity;
      totalPrice.value += product.price * (quantity.value - product.quantity.value);
      product.quantity = quantity;
    }
  }

  void decreaseQuantity(Product product, RxInt quantity) {
    var index = cartItems.indexOf(product);
    if (index != -1) {
      cartItems[index].quantity = quantity;
      totalPrice.value -= product.price * (product.quantity.value - quantity.value);
      product.quantity = quantity;
    }
  }
}