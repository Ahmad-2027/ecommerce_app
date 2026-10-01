import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProductsHomePage();
  Future<List<HomeCarouselItemModel>> fetchAnnouncementsItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImp implements HomeServices {
  final fireStoreServices = FirestoreServices.instance;
  @override
  Future<List<ProductItemModel>> fetchProductsHomePage() async {
    final result = await fireStoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products,
      builder: ((data, documentId) {
        return ProductItemModel.fromMap(data);
      }),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchAnnouncementsItems() async {
    return await fireStoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcements,
      builder: ((data, documentId) {
        return HomeCarouselItemModel.fromMap(data);
      }),
    );
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    return await fireStoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categories,
      builder: ((data, documentId) {
        return CategoryModel.fromMap(data);
      }),
    );
  }

}
