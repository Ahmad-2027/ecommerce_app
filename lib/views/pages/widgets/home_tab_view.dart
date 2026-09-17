import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTabView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.grey,
            ),
          );
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                FlutterCarousel.builder(
                  itemCount: state.carouselItems.length,
                  itemBuilder:
                      (
                        BuildContext context,
                        int itemIndex,
                        int pageViewIndex,
                      ) => CachedNetworkImage(
                        imageUrl: state.carouselItems[itemIndex].imgUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),
                  options: FlutterCarouselOptions(
                    height: isLandScape
                        ? size.height * 0.45
                        : size.height * 0.2,
                    viewportFraction: isLandScape ? 0.5 : 1,
    
                    initialPage: 0,
    
                    enableInfiniteScroll: true,
    
                    autoPlay: true,
    
                    autoPlayInterval: const Duration(seconds: 5),
    
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 500,
                    ),
    
                    autoPlayCurve: Curves.linear,
    
                    pauseAutoPlayOnTouch: true,
    
                    enlargeCenterPage: true,
    
                    enlargeFactor: 0.3,
                    slideIndicator: CircularWaveSlideIndicator(),
                    indicatorMargin: 2,
                    showIndicator: true,
                    pageSnapping: true,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivales",
                      style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight(600)),
                    ),
                    Text(
                      "See All",
                      style: Theme.of(context).textTheme.titleMedium!
                          .copyWith(
                            fontWeight: FontWeight(600),
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  itemCount: state.productItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLandScape ? 4 : 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) => ProductItem(
                    productItemModel: state.productItems[index],
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeLoadingError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight(600)),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
