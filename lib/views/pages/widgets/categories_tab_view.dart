import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_models/category_cubit/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocProvider(
      create: (context) {
        final cubit = CategoryCubit();
        cubit.getCategories();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<CategoryCubit, CategoryState>(
            bloc: BlocProvider.of<CategoryCubit>(context),
            buildWhen: (previous, current) =>
                current is CategoriesLoading ||
                current is CategoriesLoaded ||
                current is CategoryLoadingError,
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return Center(
                  child: const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (state is CategoriesLoaded) {
                final categories = state.categores;
                return ListView.builder(
                  scrollDirection: isLandScape
                      ? Axis.horizontal
                      : Axis.vertical,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: isLandScape ? size.width * 0.5 : size.width * 0.8,
                    child: Padding(
                      padding: isLandScape
                          ? EdgeInsets.symmetric(horizontal: 8.0)
                          : EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: () {},
                        child: LayoutBuilder(
                          builder: (context, constraints) => Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: categories[index].imgUrl,
                                  width: isLandScape
                                      ? size.width * 0.6
                                      : size.width,
                                  height: isLandScape
                                      ? size.height * 0.8
                                      : size.height * 0.2,
                                  fit: BoxFit.fill,

                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),

                                  errorWidget: (context, url, error) =>
                                      const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ),
                                ),
                              ),
                              Positioned(
                                top: 30,

                                left: index % 2 == 0
                                    ? 15
                                    : isLandScape
                                    ? constraints.maxWidth * 0.75
                                    : constraints.maxWidth * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categories[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: categories[index].textColor,
                                            fontWeight: FontWeight(800),
                                          ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${categories[index].productsCount} Products",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: categories[index].textColor,
                                            fontWeight: FontWeight(800),
                                          ),
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
              } else if (state is CategoryLoadingError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Some thing went wrong"));
              }
            },
          );
        },
      ),
    );
  }
}
