
import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getHomeData() {
    emit(HomeLoading());
    Future.delayed(Duration(seconds: 2), () {
      emit(
        HomeLoaded(
          carouselItems: dummyHomeCarouselItems,
          productItems: dummyProducts,
        ),
      );
    });
  }
}
