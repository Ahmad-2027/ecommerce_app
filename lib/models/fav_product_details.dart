import 'package:ecommerce_app/models/product_item_model.dart';

class FavoriteProductWithDetails {
  final String favId;
  final ProductItemModel product;

  FavoriteProductWithDetails({
    required this.favId,
    required this.product,
  });
}