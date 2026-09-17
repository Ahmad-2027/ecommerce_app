import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String productId;
  final dynamic cubit;
  final int? initialvalue;
  const new({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
    this.initialvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              child: IconButton(
                onPressed: () {
                  initialvalue == null
                      ? cubit.decerementCounter(productId)
                      : cubit.decerementCounter(productId,initialvalue);
                },
                icon: Icon(Icons.remove, size: 20),
                color: value == 1 ? Colors.grey[400] : Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "$value",
              style: Theme.of(context).textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight(500)),
            ),
            SizedBox(width: 8),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),

              child: IconButton(
                onPressed: () {
                  initialvalue == null
                      ? cubit.incerementCounter(productId)
                      : cubit.incerementCounter(productId,initialvalue);
                },
                icon: Icon(Icons.add, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
