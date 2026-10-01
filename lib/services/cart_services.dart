import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';

abstract class CartServices {
  Future<List<CartModel>> fetchCartItems(String userId);
  Future<void> deleteCartItem(String userId, String cartItemId);
  Future<void> updateCartItemQuantity(String userId, CartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final fireStroreServices = FirestoreServices.instance;
  @override
  Future<List<CartModel>> fetchCartItems(String userId) async {
    return await fireStroreServices.getCollection<CartModel>(
      path: ApiPaths.cartItems(userId),
      builder: (data, documentId) => CartModel.fromMap(data),
    );
  }

  @override
  Future<void> deleteCartItem(String userId, String cartItemId) async {
    await fireStroreServices.deleteData(
      path: ApiPaths.cartItem(userid: userId, cartItemId: cartItemId),
    );
  }

  @override
  Future<void> updateCartItemQuantity(String userId, CartModel cartItem) async {
    await fireStroreServices.setData(
      path: ApiPaths.cartItem(userid: userId, cartItemId: cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
