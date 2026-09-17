import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/add_new_payment_card_cubit/add_new_payment_card_cubit.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/pages/add_new_card.dart';
import 'package:ecommerce_app/views/pages/checkout_page.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_nav_bar.dart';
import 'package:ecommerce_app/views/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (_) => const BottomNavBar(),
          settings: settings,
        );

      case AppRoutes.productDetailsPage:
        final String productId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            final cartCubit = context.read<CartCubit>();

            return BlocProvider.value(
              value: cartCubit,
              child: BlocProvider(
                create: (context) {
                  final product = ProductDetailsCubit();
                  product.getProductById(productId);
                  return product;
                },
                child: ProductDetailsPage(productId: productId),
              ),
            );
          },
          settings: settings,
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => CheckoutPage(),
          settings: settings,
        );
      case AppRoutes.addNewCardMethod:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => AddNewPaymentCardCubit(),
              child: AddNewPaymentCardPage(),
            ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No Route Found ${settings.name}")),
          ),
        );
    }
  }
}
