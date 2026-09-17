part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> productItems;
  HomeLoaded({required this.carouselItems, required this.productItems});
}

final class HomeLoadingError extends HomeState {
  final String message;
  HomeLoadingError({required this.message});
}
