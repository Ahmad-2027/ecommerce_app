import 'package:ecommerce_app/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final int quantity;
  final ProductItemModel product;
  final ProductSize size;

  AddToCartModel({
    required this.id,
    required this.quantity,
    required this.product,
    required this.size,
  });

  AddToCartModel copyWith({
    String? id,
    int? quantity,
    ProductItemModel? product,
    ProductSize? size,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
      size: size ?? this.size,
    );
  }

  double getSubTotale() {
    return product.price * quantity;
  }
}

List<AddToCartModel> dummyCart = [];
