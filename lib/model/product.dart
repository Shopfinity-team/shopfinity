class Product {
  final String title;
  final String imageUrl;
  final double price;
  final double? productRate;
  final String? description;
  final int? quantity;

  Product(
      {required this.title,
      required this.imageUrl,
      required this.price,
      this.productRate,
      this.description,
      this.quantity});
}
