import 'package:animation_project/models/payment_cart_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 36,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Methods",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: paymentMethodsCubit,
                buildWhen:
                    (previous, current) =>
                        current is FetchedPaymentMethods ||
                        current is FetchingPaymentMethods ||
                        current is FetchingPaymentMethodsError,
                builder: (_, state) {
                  if (state is FetchingPaymentMethods) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FetchedPaymentMethods) {
                    final paymentCard = state.paymentCards;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentCard.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final paymentCard = dummyPaymentCards[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColor.grey2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
                                child: Image.asset(
                                  "images/mastercard_logo.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(paymentCard.cardNumber),
                            subtitle: Text(paymentCard.cardHolderName),
                          ),
                        );
                      },
                    );
                  } else if (state is FetchingPaymentMethodsError) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 8,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(AppRoutes.addNewCardRoute);
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.grey2
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.add),
                      )),
                    title: Text("Add new card"),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              MainBotton(text: "Confirm Payment",
              onTap: (){},),
              
            ],
          ),
        ),
      ),
    );
  }
}
