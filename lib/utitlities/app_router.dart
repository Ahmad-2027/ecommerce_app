
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/view_models/location_cubit/location_cubit.dart';
import 'package:ecommerce_app/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/pages/add_new_card.dart';
import 'package:ecommerce_app/views/pages/checkout_page.dart';
import 'package:ecommerce_app/views/pages/choose_location_page.dart';
import 'package:ecommerce_app/views/pages/create_account_page.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_nav_bar.dart';
import 'package:ecommerce_app/views/pages/login_page.dart';
import 'package:ecommerce_app/views/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (_) {
            return BottomNavBar();
          },
          settings: settings,
        );

      case AppRoutes.productDetailsPage:
        final String productid = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            final cartCubit = context.read<CartCubit>();

            return BlocProvider.value(
              value: cartCubit,
              child: BlocProvider(
                create: (context) {
                  final cubit = ProductDetailsCubit();
                  cubit.getProductById(productid);
                  return cubit;
                },
                child: ProductDetailsPage(productid: productid),
              ),
            );
          },
          settings: settings,
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = CheckoutCubit();
              cubit.getCartItemscheckoutPage();
              return cubit;
            },
            child: CheckoutPage(),
          ),
          settings: settings,
        );
      case AppRoutes.loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: settings,
        );
      case AppRoutes.createAccountPage:
        return MaterialPageRoute(
          builder: (_) => CreateAccountPage(),
          settings: settings,
        );
      case AppRoutes.chooseShippingLocation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = LocationCubit();
              cubit.getLocations();
              return cubit;
            },
            child: ChooseLocationPage(),
          ),
          settings: settings,
        );
      case AppRoutes.addNewCardMethod:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PaymentMethodsCubit(),
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
