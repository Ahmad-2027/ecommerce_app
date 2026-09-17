import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingPayment extends StatelessWidget {
  final String title;
  const new({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.addNewCardMethod).then((value)=>checkoutCubit.getCartItems());
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
