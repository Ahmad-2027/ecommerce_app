import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/counter.dart';
import 'package:ecommerce_app/views/pages/widgets/product_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const new({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocProvider.value(
      value: BlocProvider.of<CartCubit>(context),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        buildWhen: (previous, current) =>
            current is ProductDetailsLoaded ||
            current is ProductDetailsLoading ||
            current is ProductDetailsLoadingError,
        bloc: cubit,
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else if (state is ProductDetailsLoadingError) {
            return Scaffold(body: Center(child: Text("Loading Error")));
          } else if (state is ProductDetailsLoaded) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "Product Details",
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight(500)),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              ),
              body: SafeArea(
                top: false,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.62,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: SafeArea(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: state.product.imgUrl,

                              height: size.height * 0.4,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.47),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.product.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight(600),
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 25,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            state.product.averageRate
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight(600),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<
                                    ProductDetailsCubit,
                                    ProductDetailsState
                                  >(
                                    bloc: cubit,
                                    builder: (context, state) {
                                      if (state
                                          is QuantityCounterChangedInProductDetailsPage) {
                                        return CounterWidget(
                                          productId: productId,
                                          value: state.value,
                                          cubit: cubit,
                                        );
                                      } else if (state
                                          is ProductDetailsLoaded) {
                                        return CounterWidget(
                                          productId: productId,
                                          value: 1,
                                          cubit: cubit,
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                    buildWhen: (previous, current) =>
                                        current
                                            is QuantityCounterChangedInProductDetailsPage ||
                                        current is ProductDetailsLoaded,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Size",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is ProductSizeSelected ||
                                    current is ProductDetailsLoaded,
                                builder: (context, state) {
                                  if (state is ProductDetailsLoaded) {
                                    return ProductSizesWidget(
                                      id: productId,
                                      productSize: state.product.size,
                                    );
                                  } else if (state is ProductSizeSelected) {
                                    return ProductSizesWidget(
                                      id: productId,
                                      productSize: state.size,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Description",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.product.description,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      fontWeight: FontWeight(600),
                                      color: Colors.black54,
                                    ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: '\$',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: state.product.price
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child:
                                        BlocBuilder<
                                          ProductDetailsCubit,
                                          ProductDetailsState
                                        >(
                                          bloc: cubit,
                                          buildWhen: (previous, current) =>
                                              current is ProductAddedToCart ||
                                              current is ProductAddingToCart,
                                          builder: (context, state) {
                                            if (state is ProductAddingToCart) {
                                              return ElevatedButton(
                                                onPressed: () {},
                                                child:
                                                    CupertinoActivityIndicator(),
                                              );
                                            } else if (state
                                                is ProductAddedToCart) {
                                              return ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Theme.of(
                                                    context,
                                                  ).primaryColor,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: null,
                                                child: const Text(
                                                  "Added to cart",
                                                ),
                                              );
                                            }
                                            return ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                if (cubit.size != null) {
                                                  BlocProvider.of<
                                                        ProductDetailsCubit
                                                      >(context)
                                                      .addToCart(productId);
                                                  context
                                                      .read<CartCubit>()
                                                      .getCartItems();
                                                } else {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Please select size",
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              label: Text("Add to cart"),
                                              icon: Icon(
                                                Icons.shopping_bag_outlined,
                                              ),
                                            );
                                          },
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(body: Center(child: Text("Some thing went wrong")));
          }
        },
      ),
    );
  }
}
