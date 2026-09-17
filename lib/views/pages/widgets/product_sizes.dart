import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSizesWidget extends StatelessWidget {
  final String id;
  final ProductSize? productSize;
  const new({super.key, required this.id, this.productSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ProductSize.values
          .map(
            (size) => Padding(
              padding: const EdgeInsetsGeometry.only(right: 8.0, top: 5),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<ProductDetailsCubit>(context)
                      .productSizeSeleceted(size);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: productSize == null
                        ? Colors.grey[200]
                        : size == productSize
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      size.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: productSize == null
                            ? Colors.black
                            : size == productSize
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
