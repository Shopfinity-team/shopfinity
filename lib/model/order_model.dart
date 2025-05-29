import 'package:shopfinity/model/product_model.dart';

class OrderModel {
  String? orderId;
  String? customerName;
  List<Product> products = [];
  int? quantity;
  double? price;
  String? orderDate;
  
  // Address details
  String? country;
  String? address;
  String? apt;
  String? district;
  String? city;
  String? state;
  String? postalCode;
  
  // Payment details
  String? nameOnCard;
  String? cardNumber;
  String? expiryDate;
  String? cvv;
  
  // Order status
  String? deliveryStatus;
  String? paymentStatus;

  OrderModel({
    this.orderId,
    this.customerName,
    required this.products,
    this.quantity,
    this.price,
    this.orderDate,
    this.country,
    this.address,
    this.apt,
    this.district,
    this.city,
    this.state,
    this.postalCode,
    this.nameOnCard,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.deliveryStatus,
    this.paymentStatus,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    customerName = json['customerName'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    } else {
      products = [];
    }
    quantity = json['quantity'];
    price = json['price']?.toDouble();
    orderDate = json['orderDate'];
    
    // Address details
    country = json['country'];
    address = json['address'];
    apt = json['apt'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    
    // Payment details
    nameOnCard = json['nameOnCard'];
    cardNumber = json['cardNumber'];
    expiryDate = json['expiryDate'];
    cvv = json['cvv'];
    
    // Order status
    deliveryStatus = json['deliveryStatus'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['customerName'] = customerName;
    if (products.isNotEmpty) {
      data['products'] = products.map((v) => v.toJson()).toList();
    } else {
      data['products'] = [];
    }
    data['quantity'] = quantity;
    data['price'] = price;
    data['orderDate'] = orderDate;
    
    // Address details
    data['country'] = country;
    data['address'] = address;
    data['apt'] = apt;
    data['district'] = district;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    
    // Payment details
    data['nameOnCard'] = nameOnCard;
    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['cvv'] = cvv;
    
    // Order status
    data['deliveryStatus'] = deliveryStatus;
    data['paymentStatus'] = paymentStatus;
    
    return data;
  }
}