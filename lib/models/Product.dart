class Product {
  final String id;
  final String name;
  final String category;
  final String brand;
  final bool status;
  final String description;
  final int quantity;
  final String image_url;
  final int price;
  final String seller_id;
  final String seller_first_name;
  final String seller_last_name;
  final String seller_phone;

  Product(
      {required this.seller_first_name,
      required this.seller_last_name,
      required this.seller_phone,
      required this.id,
      required this.status,
      required this.name,
      required this.category,
      required this.brand,
      required this.description,
      required this.quantity,
      required this.price,
      required this.image_url,
      required this.seller_id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["p_id"],
      name: json["p_name"],
      category: json["p_category"],
      brand: json["p_brand"],
      status: json["p_status"],
      description: json["p_description"],
      quantity: json["p_quantity"],
      price: json["p_price"],
      image_url: json["p_image"],
      seller_id: json["s_id"],
      seller_first_name: json["s_first_name"] ?? '', // it might be null
      seller_last_name: json["s_last_name"] ?? '',
      seller_phone: json["s_phone"] ?? '',
    );
  }
}
