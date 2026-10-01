import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/favorite_Product_cubit/fav_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const new({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<FavProductCubit>(context);
    cubit.fetchFavProductsDetails();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavProductCubit>(context);
    return BlocBuilder<FavProductCubit, FavProductState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is FetchedFavoriteProducts ||
          current is FetchingFavoriteProducts ||
          current is FetchingFavoriteProductsError,
      builder: (context, state) {
        if (state is FetchedFavoriteProducts) {
          final favProducts = state.favProducts;
          if (favProducts.isEmpty) {
            return const Center(child: Text("No favorites product !"));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8,
              ),
              child: RefreshIndicator.adaptive(
                onRefresh: () async => await cubit.fetchFavProductsDetails(),
                child: ListView.separated(
                  /*      shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(), */
                  itemCount: favProducts.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.productDetailsPage,
                          arguments: favProducts[index].product.id,
                        ),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CachedNetworkImage(
                          width: 70,
                          height: 70,
                          imageUrl: favProducts[index].product.imgUrl,

                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                            semanticLabel: error.toString(),
                          ),
                        ),
                        title: Text(favProducts[index].product.name),
                        subtitle: Text(
                          "\$ ${favProducts[index].product.price}",
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            cubit.selectedPRoductId =
                                favProducts[index].product.id;
                            await cubit.removeFromFavorites(
                              favProducts[index].favId,
                            );
                            await cubit.fetchFavProductsDetails();
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Divider(
                      color: Colors.grey[200],
                      endIndent: 10,
                      indent: 10,
                    ),
                  ),
                ),
              ),
            );
          }
        } else if (state is FetchingFavoriteProducts) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return Center(child: Text("Something went wrong"));
        }
      },
    );
  }
}
