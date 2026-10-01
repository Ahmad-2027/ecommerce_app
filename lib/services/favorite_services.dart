import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/favorite_product_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';

abstract class FavoriteServices {
  Future<void> addFavoriteProduct(
    FavoriteProductModel favProduct,
    String userId,
  );
  Future<void> removeFavoriteProduct(String favProductId, String userId);
  Future<List<FavoriteProductModel>> fetchFavoritesProductList(String userId);
  Future<List<ProductItemModel>> fetchProductsByIds(List<String> productIds);
}

class FavoriteServicesImp implements FavoriteServices {
  final fireStoreServices = FirestoreServices.instance;
  @override
  Future<void> addFavoriteProduct(
    FavoriteProductModel favProduct,
    String userId,
  ) async {
    await fireStoreServices.setData(
      path: ApiPaths.favProductItem(userId, favId: favProduct.id),
      data: favProduct.toMap(),
    );
  }

  @override
  Future<void> removeFavoriteProduct(String favProductId, String userId) async {
    await fireStoreServices.deleteData(
      path: ApiPaths.favProductItem(userId, favId: favProductId),
    );
  }

  @override
  Future<List<FavoriteProductModel>> fetchFavoritesProductList(
    String userId,
  ) async {
    
      return await fireStoreServices.getCollection<FavoriteProductModel>(
        path: ApiPaths.favProducts(userId),
        builder: (data, d) {
          return FavoriteProductModel.fromMap(data);
        },
      );
   
  }

  @override
  Future<List<ProductItemModel>> fetchProductsByIds(
    List<String> productIds,
  ) async {
    try {
      if (productIds.isEmpty) {
        return List.empty();
      }

      return await fireStoreServices.getCollection<ProductItemModel>(
        path: ApiPaths.products,
        queryBuilder: (query) {
          return query.where(FieldPath.documentId, whereIn: productIds);
        },
        builder: (data, documentId) {
          return ProductItemModel.fromMap(data);
        },
      );
    } catch (e) {
      return List.empty();
    }
  }
}
