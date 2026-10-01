import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String productId;
  final dynamic cubit;
  final int? initialvalue;
  final CartModel? cartModel;
  const new({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
    this.initialvalue,
    this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 3),
        child: BlocConsumer<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              current is QuantityCounterChangingInCartPageError &&
                  cartModel != null
              ? cartCubit.selectedcartItemId == cartModel!.id
              : false,
          listener: (context, state) {
            if (state is QuantityCounterChangingInCartPageError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          bloc: cartCubit,
          buildWhen: (previous, current) {
            if (cartModel == null) {
              return false;
            }

            if (current is QuantityCounterChangingInCartPage) {
              return current.cartItemId == cartModel!.id;
            }

            if (current is QuantityCounterChangedInCartPage) {
              return current.cartItemId == cartModel!.id;
            }

            if (current is QuantityCounterChangingInCartPageError) {
              return current.cartItemId == cartModel!.id;
            }

            return false;
          },
          builder: (context, state) {
            if (state is QuantityCounterChangingInCartPage) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),

                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove, size: 20),
                      color: value == 1 ? Colors.grey[400] : Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "$value",
                    style: Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight(500)),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),

                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add, size: 20),
                    ),
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),

                  child: IconButton(
                    onPressed: () {
                      if (cartModel != null) {
                        cartCubit.selectedcartItemId = cartModel!.id;
                      }
                      initialvalue == null
                          ? cubit.decerementCounter(cartModel ?? productId)
                          : cubit.decerementCounter(cartModel);
                    },
                    icon: Icon(Icons.remove, size: 20),
                    color: value == 1 ? Colors.grey[400] : Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "$value",
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight(500)),
                ),
                SizedBox(width: 8),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),

                  child: IconButton(
                    onPressed: () {
                      if (cartModel != null) {
                        cartCubit.selectedcartItemId = cartModel!.id;
                      }
                      initialvalue == null
                          ? cubit.incerementCounter(cartModel ?? productId)
                          : cubit.incerementCounter(cartModel);
                    },
                    icon: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
