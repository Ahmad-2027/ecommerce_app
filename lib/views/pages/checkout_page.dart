import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/checkout_headlines.dart';
import 'package:ecommerce_app/views/pages/widgets/empty_shipping_payment.dart';
import 'package:ecommerce_app/views/pages/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const new({super.key});

  Widget _buildPaymentMethodsWidget(
    BuildContext context,
    PaymentCardModel? paymentMethod,
  ) {
    if (paymentMethod == null) {
      return EmptyShippingPayment(
        title: "Add payment method",
        onTap: () async {
          final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AppRoutes.addNewCardMethod).then((value) async {
            if (value == true) {
              await checkoutCubit.getCartItemscheckoutPage();
            }
          });
        },
      );
    } else {
      return PaymentMethodItem(paymentMethod: paymentMethod);
    }
  }

  Widget _buildLocationWidget(BuildContext context, LocationModel? location) {
    if (location == null) {
      final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
      return EmptyShippingPayment(
        title: "Add shipping address",
        onTap: () {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(AppRoutes.chooseShippingLocation).then((value) async {
            if (value == true) {
              return await checkoutCubit.getCartItemscheckoutPage();
            }
          });
        },
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: location.imgUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.city,
                  style: Theme.of(context).textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight(600)),
                ),
                Text(
                  "${location.city} , ${location.country}",
                  style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout"), centerTitle: true),

      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: BlocProvider.of<CheckoutCubit>(context),
        buildWhen: (previous, current) =>
            current is CheckoutItemsLoaded ||
            current is CheckoutItemsLoading ||
            current is CheckoutItemsLoadingError,
        builder: (context, state) {
          if (state is CheckoutItemsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CheckoutItemsLoaded) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      CheckoutHeadlinesItem(
                        title: "Address",
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(AppRoutes.chooseShippingLocation)
                              .then((value) async {
                                if (value == true) {
                                  return await checkoutCubit
                                      .getCartItemscheckoutPage();
                                }
                              });
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildLocationWidget(context, state.shippingLocation),
                      const SizedBox(height: 12),
                      CheckoutHeadlinesItem(
                        title: "Products",

                        numOfProducts: state.numOfProducts,
                      ),
                      const SizedBox(height: 18),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItemModel = state.cartItems[index];
                          return Row(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: cartItemModel.product.imgUrl,
                                  height: size.height * 0.13,
                                  width: size.width * 0.3,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    semanticLabel: error.toString(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItemModel.product.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight(500),
                                          ),
                                    ),

                                    SizedBox(height: 16),
                                    Text.rich(
                                      TextSpan(
                                        text: "Size : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.grey),
                                        children: [
                                          TextSpan(
                                            text: cartItemModel.size.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight(600),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: "Items number : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                text: cartItemModel.quantity
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight: FontWeight(
                                                        600,
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "\$${cartItemModel.getSubTotale()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                fontWeight: FontWeight(600),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
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
                      const CheckoutHeadlinesItem(title: "Payment Methods"),

                      const SizedBox(height: 12),
                      _buildPaymentMethodsWidget(context, state.paymentMethod),
                      const SizedBox(height: 18),
                      Divider(
                        color: Colors.grey[200],
                        endIndent: 10,
                        indent: 10,
                      ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          Text(
                            '\$${state.totalAmount.toStringAsFixed(1)}',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight(600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Proceed to buy",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight(600),
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
