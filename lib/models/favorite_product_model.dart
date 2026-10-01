class FavoriteProductModel {
  final String id;
  final String productId;

  const FavoriteProductModel({required this.id, required this.productId});

  factory FavoriteProductModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProductModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'productId': productId};
  }
}
