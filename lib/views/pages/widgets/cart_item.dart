import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final AddToCartModel cartIemModel;
  const new({super.key, required this.cartIemModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CartCubit>(context);
    return BlocBuilder<CartCubit, CartState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              DecoratedBox(
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
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartIemModel.product.name,
                      style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight(500)),
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
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          current is QuantityCounterChangedInCartPage &&
                              current.productId == cartIemModel.id ||
                          current is CartItemsLoaded,
                      builder: (context, state) {
                        if (state is QuantityCounterChangedInCartPage) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CounterWidget(
                                productId: cartIemModel.id,
                                value: state.value,
                                cubit: cubit,
                              ),
                              Text(
                                "\$${cartIemModel.product.price * state.value}",
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
                                cubit: cubit,
                                initialvalue: cartIemModel.quantity,
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
