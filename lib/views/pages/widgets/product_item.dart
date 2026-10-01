import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/favorite_Product_cubit/fav_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final String? favId;
  final ProductItemModel productItemModel;
  const new({super.key, required this.productItemModel, required this.favId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final cubit = BlocProvider.of<FavProductCubit>(context);
    return InkWell(
      onTap: () => Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamed(AppRoutes.productDetailsPage, arguments: productItemModel.id),
      child: Column(
        children: [
          Container(
            height: isLandScape ? size.height * 0.3 : size.height * 0.125,
            width: isLandScape ? size.width * 0.3 : size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CachedNetworkImage(
                      imageUrl: productItemModel.imgUrl,

                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.red,
                        semanticLabel: error.toString(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white38,
                    ),
                    child: BlocBuilder<FavProductCubit, FavProductState>(
                      buildWhen: (previous, current) {
                        return ((current is AddedProductToFavorites ||
                                    current is RemovedProductFromFavorites ||
                                    current is FavProductInitial ||
                                    current is AddingProductToFavorites ||
                                    current
                                        is RemovingProductToFavoritesError ||
                                    current is AddingProductToFavoritesError ||
                                    current is RemovingProductFromFavorites) &&
                                productItemModel.id ==
                                    cubit.selectedPRoductId) ||
                            current is FavProductInitial;
                      },

                      bloc: BlocProvider.of<FavProductCubit>(context),

                      builder: (context, state) {
                        if (state is RemovingProductFromFavorites) {
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border),
                          );
                        } else if (state is AddingProductToFavorites) {
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            ),
                          );
                        } else if (state is AddedProductToFavorites) {
                          return IconButton(
                            onPressed: () async {
                              cubit.selectedPRoductId = productItemModel.id;
                              await cubit.removeFromFavorites(state.favId);
                              await cubit.fetchFavProductsDetails();
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            ),
                          );
                        } else if (state is RemovedProductFromFavorites) {
                          return IconButton(
                            onPressed: () async {
                              cubit.selectedPRoductId = productItemModel.id;
                              await cubit.addToFavorites(productItemModel.id);
                              await cubit.fetchFavProductsDetails();
                            },
                            icon: Icon(Icons.favorite_border),
                          );
                        }
                        return IconButton(
                          onPressed: () async {
                            if (productItemModel.isFavorite) {
                              cubit.selectedPRoductId = productItemModel.id;
                              await cubit.removeFromFavorites(favId!);

                            } else {
                              cubit.selectedPRoductId = productItemModel.id;
                              await cubit.addToFavorites(productItemModel.id);
                            }
                                await cubit.fetchFavProductsDetails();
                          },
                          icon: productItemModel.isFavorite
                              ? Icon(Icons.favorite_rounded, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),
          Text(
            productItemModel.name,
            style: Theme.of(context).textTheme.titleSmall!
                .copyWith(fontWeight: FontWeight(600)),
          ),
          Text(
            productItemModel.category,
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight(500), color: Colors.grey),
          ),
          Text(
            "\$ ${productItemModel.price}",
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight(500)),
          ),
        ],
      ),
    );
  }
}
