import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/utils/app_color.dart';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productItem});
  final ProductItemModel productItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.grey2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(productItem.imgUrl, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,

              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          productItem.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
