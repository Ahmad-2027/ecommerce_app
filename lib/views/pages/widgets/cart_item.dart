import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final CartModel cartIemModel;
  const new({super.key, required this.cartIemModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return BlocBuilder<CartCubit, CartState>(
      bloc: cartCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              InkWell(
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.productDetailsPage,
                      arguments: cartIemModel.product.id,
                    ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: cartIemModel.product.imgUrl,
                    height: size.height * 0.13,
                    width: size.width * 0.3,
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
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocListener<CartCubit, CartState>(
                      listenWhen: (previous, current) =>
                          current is CartItemRemoved,
                      listener: (context, state) async {
                        if (state is CartItemRemoved) {
                          await cartCubit.getCartItems();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cartIemModel.product.name,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight(500)),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            bloc: cartCubit,
                            buildWhen: (previous, current) =>
                                (current is CartItemRemoved ||
                                    current is CartItemRemoving ||
                                    current is CartItemRemovingError) &&
                                cartIemModel.id == cartCubit.selectedcartItemId,
                            builder: (context, state) {
                              if (state is CartItemRemoving) {
                                return const CircularProgressIndicator.adaptive();
                              }
                              return IconButton(
                                onPressed: () async {
                                  cartCubit.selectedcartItemId =
                                      cartIemModel.id;
                                  await cartCubit.removeCartItem(
                                    cartIemModel.id,
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_sharp,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        text: "Size : ",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: cartIemModel.size.name,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight(600)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: cartCubit,
                      buildWhen: (previous, current) =>
                          ((current is QuantityCounterChangingInCartPage ||
                                  current
                                      is QuantityCounterChangingInCartPageError ||
                                  current
                                      is QuantityCounterChangedInCartPage) &&
                              cartCubit.selectedcartItemId ==
                                  cartIemModel.id) ||
                          current is CartItemsLoaded,
                      builder: (context, state) {
                        if (state is QuantityCounterChangedInCartPage) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                productId: cartIemModel.id,
                                value: state.cartModel.quantity,
                                cubit: cartCubit,
                                cartModel: state.cartModel,
                              ),
                              Text(
                                "\$${cartIemModel.product.price * state.cartModel.quantity}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                            ],
                          );
                        } else if (state is QuantityCounterChangingInCartPage) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                productId: cartIemModel.id,
                                value: state.expectedValue,
                                cubit: cartCubit,
                                cartModel: cartIemModel,
                              ),
                              Text(
                                "\$${cartIemModel.product.price * state.expectedValue}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                            ],
                          );
                        } else if (state
                            is QuantityCounterChangingInCartPageError) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                productId: cartIemModel.id,
                                value: state.oldValue,
                                cubit: cartCubit,
                                cartModel: cartIemModel,
                              ),
                              Text(
                                "\$${cartIemModel.product.price * state.oldValue}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                            ],
                          );
                        } else if (state is CartItemsLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                productId: cartIemModel.id,
                                value: cartIemModel.quantity,
                                cubit: cartCubit,
                                initialvalue: cartIemModel.quantity,
                                cartModel: cartIemModel,
                              ),
                              Text(
                                "\$${cartIemModel.getSubTotale()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight(600)),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
