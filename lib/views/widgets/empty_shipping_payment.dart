import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  const EmptyShippingAndPayment({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.addNewCardRoute)
            .then((value) => checkoutCubit.getCartItem());
      },
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.grey2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Icon(Icons.add, size: 30),
              Text(title, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
