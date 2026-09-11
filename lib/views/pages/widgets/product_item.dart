import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItemModel;
  const new({super.key, required this.productItemModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    productItemModel.imgUrl,
                    fit: BoxFit.contain,
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
                        ? Icon(Icons.star, color: Colors.orange)
                        : Icon(Icons.star_border_rounded),
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
    );
  }
}
