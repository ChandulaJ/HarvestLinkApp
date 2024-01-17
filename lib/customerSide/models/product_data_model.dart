class ProductDataModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String unit;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.unit,
  });

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    print("inside product data model");
    return ProductDataModel(
      id: map['id'] ?? '',
      name: map['Name'] ?? '',
      price: map['Price'] ?? 0.0,
      imageUrl: map['Image'] ?? '',
      unit: map['Unit'] ?? '',
    );
  }
}
