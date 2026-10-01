import 'package:ecommerce_app/models/product_item_model.dart';

class CartModel {
  final String id;
  final int quantity;
  final ProductItemModel product;
  final ProductSize size;

 const CartModel({
    required this.id,
    required this.quantity,
    required this.product,
    required this.size,
  });

  CartModel copyWith({
    String? id,
    int? quantity,
    ProductItemModel? product,
    ProductSize? size,
  }) {
    return CartModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
      size: size ?? this.size,
    );
  }

  double getSubTotale() {
    return product.price * quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toMap(),
      'size': size.name,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      product: ProductItemModel.fromMap(
        Map<String, dynamic>.from(map['product'] as Map),
      ),
      size: ProductSize.fromString(map['size'] as String),
    );
  }
  
}

List<CartModel> dummyCart = [];
