import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/secure_password_cubit/secure_password_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/label_with_text_field.dart';
import 'package:ecommerce_app/views/pages/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userNameController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Start shopping with create you account",
                    style: Theme.of(context).textTheme.titleSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: "User Name",
                    controller: userNameController,
                    prefixIcon: Icons.person,

                    hintText: "Please enter user name",
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: "Email",
                    controller: emailController,
                    prefixIcon: Icons.email,

                    hintText: "Please enter your email",
                  ),
                  const SizedBox(height: 24),
                  BlocProvider(
                    create: (context) => SecurePasswordCubit(),
                    child:
                        BlocBuilder<SecurePasswordCubit, SecurePasswordState>(
                          builder: (context, state) {
                            return BlocBuilder<
                              SecurePasswordCubit,
                              SecurePasswordState
                            >(
                              bloc: BlocProvider.of<SecurePasswordCubit>(
                                context,
                              ),
                              builder: (context, state) {
                                if (state is PasswordIsUnVisible ||
                                    state is SecurePasswordInitial) {
                                  return LabelWithTextField(
                                    label: "Password",
                                    controller: passwordController,
                                    prefixIcon: Icons.password,
                                    obsecureText: true,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<SecurePasswordCubit>(
                                          context,
                                        ).setPasswordvisible();
                                      },

                                      icon: Icon(Icons.visibility),
                                    ),
                                    hintText: "Please enter your password",
                                  );
                                }
                                return LabelWithTextField(
                                  label: "Password",
                                  controller: passwordController,
                                  prefixIcon: Icons.password,
                                  obsecureText: false,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<SecurePasswordCubit>(
                                        context,
                                      ).setPasswordUnvisible();
                                    },

                                    icon: Icon(Icons.visibility_off),
                                  ),
                                  hintText: "Please enter your password",
                                );
                              },
                            );
                          },
                        ),
                  ),

                  const SizedBox(height: 36),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.homePage);
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthFailed,
                    buildWhen: (previous, current) =>
                        current is AuthDone ||
                        current is AuthFailed ||
                        current is AuthChecking,
                    builder: (context, state) {
                      if (state is AuthChecking) {
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
                            if (_keyForm.currentState!.validate()) {
                              await cubit.registerWithPasswordAndEmail(
                                email: emailController.text,
                                password: passwordController.text,
                                userName: userNameController.text
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight(600),
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("You have an account? Login"),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Or using other methods",
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        SocialMediaButton(
                          text: "Sign Up with google",
                          imgUrl: "https://cdn-icons-png.flaticon.com/128/281/281764.png",
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        SocialMediaButton(
                          text: "Sign Up with faceBook",
                          imgUrl: "https://cdn-icons-png.flaticon.com/128/15047/15047435.png",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
