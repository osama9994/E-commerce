import 'package:animation_project/models/payment_cart_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:animation_project/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:animation_project/views/widgets/checkout_headlines_item.dart';
import 'package:animation_project/views/widgets/empty_shipping_payment.dart';
import 'package:animation_project/views/widgets/payment_method_bottom_sheet.dart';
import 'package:animation_project/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
Widget _buildPaymentMethodItem(PaymentCardModel? chosenCard, BuildContext context){
  if(chosenCard !=null){
   return PaymentMethodItem(paymentCard: chosenCard,onItemTapped:() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (_){
     return SizedBox(
      
      width: double.infinity,
      height: 500,
      child: BlocProvider(
        create: (context) {
          final cubit=PaymentMethodsCubit();
          cubit.fetchPaymentMethods();
          return cubit;
        },
        child:  PaymentMethodBottomSheet(),
      ),
      );
    }
    // ignore: use_build_context_synchronously
    ).then((value)=>BlocProvider.of<CheckoutCubit>(context).getCartItem());
   },
   );
  }else{
   return  const EmptyShippingAndPayment(title: "Add Payment Method",isPayment: true,);
  }
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCartItem();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen:
                  (previous, current) =>
                      current is CheckoutLoaded ||
                      current is CheckoutLoading ||
                      current is CheckoutError,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is CheckoutLoaded) {
                  final cartItems = state.cartItem;
                  final chosenPaymentCard=state.chosenPaymentCard;
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CheckoutHeadlinesItem(title: "Address", onTap: () {}),
                            const SizedBox(height: 16,),
                            const EmptyShippingAndPayment(title: "Add shipping Address"
                            ,isPayment: false,
                            ),
                            const SizedBox(height: 16,),
                            CheckoutHeadlinesItem(
                              title: "Products",
                              namOfProduct: state.numOfProducts,
                            ),
                            
                            const SizedBox(height: 16),
                            ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(color: AppColor.grey2);
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final cartItem = cartItems[index];
                                return Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.product.name,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: "Size ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        color: AppColor.grey,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text: cartItem.size.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                            color: AppColor.black,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${cartItem.totalPrice.toStringAsFixed(1)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16,),
                            CheckoutHeadlinesItem(title: "Payment Methods", onTap: () {}),
                            const SizedBox(height: 16,),
                            _buildPaymentMethodItem(chosenPaymentCard,context),
                            Divider(color: AppColor.grey2),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: Theme.of(context).textTheme.titleMedium!
                                      .copyWith(color: AppColor.grey),
                                ),
                                Text(
                                  "\$${state.totalAmount.toStringAsFixed(1)}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                    
                            const SizedBox(height: 40),
                    
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  foregroundColor: AppColor.white,
                                ),
                                child: const Text("Proceed to Buy"),
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Something went wrong!"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
