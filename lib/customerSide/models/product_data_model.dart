class ProductDataModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String unit;
   final double quantity;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.unit,
    required this.quantity,
  });

  ProductDataModel copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? unit,
    double? quantity,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    print("inside product data model");
    return ProductDataModel(
      id: map['id'] ?? '',
      name: map['Name'] ?? '',
      price: map['Price'] ?? 0.0,
      imageUrl: map['Image'] ?? '',
      unit: map['Unit'] ?? '',
      quantity: map['Quantity']?? 0.0,
    );
  }
}
