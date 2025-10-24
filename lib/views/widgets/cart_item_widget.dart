import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/cart_cubit/cart_cubit.dart';
import 'package:animation_project/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});
  final AddToCartModel cartItem;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.grey2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              cartItem.product.imgUrl,
              height: 125,
              width: 125,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: "Size ",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColor.grey),
                    children: [
                      TextSpan(
                        text: cartItem.size.name,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColor.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is QuantityCounterLoaded &&
                          current.productId == cartItem.product.id,
                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                        value: state.value,
                        productId: cartItem.product.id,
                        cubit: cubit,
                      ),
                        Text(
                          "\$${(state.value*cartItem.product.price).toStringAsFixed(1)}",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                      
                    }
                   return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                        value: cartItem.quantity,
                        productId: cartItem.product.id,
                        cubit: cubit,
                      ),
                        Text(
                          "\$${cartItem.totalPrice.toStringAsFixed(1)}",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                      
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
