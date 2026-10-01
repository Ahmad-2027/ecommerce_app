import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/favorite_Product_cubit/fav_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          buildWhen: (previous, current) => current is AuthLoggingOut,
          listener: (context, state) {
            if (state is AuthLoggedout) {
               context.read<FavProductCubit>().clearFavorites();
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamedAndRemoveUntil(AppRoutes.loginPage, (route) => false);
            } else if (state is AuthLoggingOutFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          listenWhen: (previous, current) =>
              current is AuthLoggedout || current is AuthLoggingOutFailed,
          builder: (context, state) {
            if (state is AuthLoggingOut) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            }

            return SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await cubit.logOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Log out",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight(600),
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
