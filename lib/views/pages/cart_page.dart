import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/cart_cubit/cart_cubit.dart';
import 'package:animation_project/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<CartCubit>(context);
          return BlocBuilder<CartCubit, CartState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is CartLoaded ||
                current is CartLoading ||
                current is CartError,
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator.adaptive());
              } else if (state is CartLoaded) {
                final cartItems = state.cartItems;
                if (cartItems.isEmpty) {
                  return const Center(child: Text("No items in your Cart!"));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CartItemWidget(cartItem: cartItem);
                        },
                        separatorBuilder: (context, index) =>
                            Divider(color: AppColor.grey2),
                      ),
                      Divider(color: AppColor.grey2),

                      // ✅ BlocBuilder خاص بالـ Subtotal
                      BlocBuilder<CartCubit, CartState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is SubtotalUpdated || current is CartLoaded,
                        builder: (context, state) {
                          double subtotal = 0;

                          if (state is CartLoaded) {
                            subtotal = state.subTotal;
                          } else if (state is SubtotalUpdated) {
                            subtotal = state.subtotal;
                          }

                          return Column(
                            children: [
                              totalAndSubtotalWidget(
                                context,
                                title: "Subtotal",
                                amount: subtotal,
                              ),
                              totalAndSubtotalWidget(
                                context,
                                title: "Shipping",
                                amount: 10,
                              ),
                              const SizedBox(height: 4),
                              Dash(
                                dashColor: AppColor.grey3,
                                length:
                                    MediaQuery.of(context).size.width - 32,
                              ),
                              const SizedBox(height: 4),
                              totalAndSubtotalWidget(
                                context,
                                title: "Total Amount",
                                amount: subtotal + 10,
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColor.white,
                              backgroundColor:
                                  Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.checkoutRoute);
                            },
                            child: const Text("Checkout"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            },
          );
        },
      ),
    );
  }

  Widget totalAndSubtotalWidget(
    context, {
    required String title,
    required double amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColor.grey),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
