import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItemModel;
  const new({super.key, required this.productItemModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return InkWell(
      onTap: () => Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamed(AppRoutes.productDetailsPage, arguments: productItemModel.id),
      child: Column(
        children: [
          Container(
            height: isLandScape ? size.height * 0.3 : size.height * 0.125,
            width: isLandScape ? size.width * 0.3 : size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: productItemModel.imgUrl,
                    /* imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ), */
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                      semanticLabel: error.toString(),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white38,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: productItemModel.isFavorite
                          ? Icon(Icons.favorite_rounded, color: Colors.red)
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),
          Text(
            productItemModel.name,
            style: Theme.of(context).textTheme.titleSmall!
                .copyWith(fontWeight: FontWeight(600)),
          ),
          Text(
            productItemModel.category,
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight(500), color: Colors.grey),
          ),
          Text(
            "\$ ${productItemModel.price}",
            style: Theme.of(context).textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight(500)),
          ),
        ],
      ),
    );
  }
}
