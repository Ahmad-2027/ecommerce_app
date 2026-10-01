import 'package:ecommerce_app/models/favorite_product_model.dart';
import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorite_services.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final favServices = FavoriteServicesImp();
  final homeServices = HomeServicesImp();
  final authServices = AuthServicesImp();
  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());
      final products = await homeServices.fetchProductsHomePage();
      final carousel = await homeServices.fetchAnnouncementsItems();
      final favProducts = await favServices.fetchFavoritesProductList(
        authServices.currentUser()!.uid,
      );
      emit(
        HomeLoaded(
          carouselItems: carousel,
          productItems: products,
          favItems: favProducts,
        ),
      );
    } catch (e) {
      emit(HomeLoadingError(message: e.toString()));
    }
  }
}
