import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesTabView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ListView.builder(
      scrollDirection: isLandScape ? Axis.horizontal : Axis.vertical,
      itemCount: dummyCategories.length,
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
                      imageUrl: dummyCategories[index].imgUrl,
                      width: isLandScape ? size.width * 0.6 : size.width,
                      height: isLandScape
                          ? size.height * 0.8
                          : size.height * 0.2,
                      fit: BoxFit.fill,

                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive(
                 
                        ),
                      ),

                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
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
                          dummyCategories[index].name,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(
                                color: dummyCategories[index].textColor,
                                fontWeight: FontWeight(800),
                              ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${dummyCategories[index].productsCount} Products",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: dummyCategories[index].textColor,
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
  }
}
