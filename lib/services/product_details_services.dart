import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productid);
  Future<void> addToCart(CartModel cartItem,String userId);
}

class ProductDetailsServicesImp implements ProductDetailsServices {
  final fireStoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productid) async {
    final result = await fireStoreServices.getDocument<ProductItemModel>(
      path: ApiPaths.product(productid),
      builder: (data, documnetid) => ProductItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> addToCart(CartModel cartItem,String userId) async {
    await fireStoreServices.setData(
      path: ApiPaths.cartItem(userid:  userId, cartItemId:  cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
