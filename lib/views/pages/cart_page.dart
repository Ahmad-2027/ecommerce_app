
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();

    context.read<CartCubit>().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
      double shipping = 10;
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          current is CartItemsLoaded ||
          current is CartItemsLoading ||
          current is CartItemsLoadingError,
      builder: (context, state) {
        if (state is CartItemsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CartItemsLoaded) {
          final cartItems = state.items;

          if (cartItems.isEmpty) {
            return const Center(child: Text("No items in your cart!"));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return CartItem(cartIemModel: cartItem);
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: Colors.grey[200],
                        endIndent: 10,
                        indent: 10,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Colors.grey[200],
                      endIndent: 10,
                      indent: 10,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return BlocBuilder<CartCubit, CartState>(
                        bloc: BlocProvider.of<CartCubit>(context),
                        buildWhen: (previous, current) =>
                            current is CartItemsLoaded ||
                            current is QuantityCounterChangedInCartPage,
                        builder: (context, state) {
                          if (state is CartItemsLoaded) {
                            return Column(
                              children: [
                                titleAndAmountWidget(
                                  context,
                                  title: 'SubTotal',
                                  amount: state.subtotal,
                                ),
                                titleAndAmountWidget(
                                  context,
                                  title: 'Shipping',
                                  amount:shipping,
                                ),
                                const SizedBox(height: 8),
                                Dash(
                                  length:
                                      MediaQuery.of(context).size.width - 32,
                                  dashColor: Colors.grey[400]!,
                                ),
                                const SizedBox(height: 8),
                                titleAndAmountWidget(
                                  context,
                                  title: 'Total Amount',
                                  amount: shipping + state.subtotal,
                                ),
                              ],
                            );
                          } else if (state
                              is QuantityCounterChangedInCartPage) {
                            return Column(
                              children: [
                                titleAndAmountWidget(
                                  context,
                                  title: 'SubTotal',
                                  amount: state.newSubTotal,
                                ),
                                titleAndAmountWidget(
                                  context,
                                  title: 'Shipping',
                                  amount: shipping,
                                ),
                                const SizedBox(height: 8),
                                Dash(
                                  length:
                                      MediaQuery.of(context).size.width - 32,
                                  dashColor: Colors.grey[400]!,
                                ),
                                const SizedBox(height: 8),
                                titleAndAmountWidget(
                                  context,
                                  title: 'Total Amount',
                                  amount: shipping + state.newSubTotal,
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 40,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed(AppRoutes.checkoutRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Check Out",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight(600),
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CartItemsLoadingError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }
}

Widget titleAndAmountWidget(
  BuildContext context, {
  required String title,
  required double amount,
}) {
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!
              .copyWith(color: Colors.grey),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
