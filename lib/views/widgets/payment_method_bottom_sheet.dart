import 'package:animation_project/utils/app_color.dart';
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

              BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                bloc: paymentMethodsCubit,
                buildWhen:
                    (previous, current) =>
                        current is FetchingPaymentMethods ||
                        current is FetchedPaymentMethods ||
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
                        final paymentcard = paymentCard[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            onTap: () {
                              paymentMethodsCubit.changePaymentMethod(
                                paymentcard.id,
                              );
                            },
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColor.grey2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 8,
                                ),
                                child: Image.asset(
                                  "images/mastercard_logo.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(paymentcard.cardNumber),

                            subtitle: Text(paymentcard.cardHolderName),
                            trailing: BlocBuilder<
                              PaymentMethodsCubit,
                              PaymentMethodsState
                            >(
                              bloc: paymentMethodsCubit,
                              buildWhen:
                                  (previous, current) =>
                                      current is PaymentMethodChosen,
                              builder: (context, state) {
                                if (state is PaymentMethodChosen) {
                                  final chosenPaymentMethod =
                                      state.chosenPayment;
                                  return Radio<String>(
                                    value: paymentcard.id,
                                    groupValue: chosenPaymentMethod.id,
                                    onChanged: (id) {
                                      paymentMethodsCubit.changePaymentMethod(
                                        id!,
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FetchingPaymentMethodsError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/addNewCardRoute");
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.grey2,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                    title: const Text("Add new card"),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                bloc: paymentMethodsCubit,
                listenWhen:(previous, current) => current is ConfirmPaymentSuccess,
                buildWhen:
                    (previous, current) =>
                        current is ConfirmPaymentLoading ||
                        current is ConfirmPaymentSuccess ||
                        current is ConfirmPaymentFailure,
                        listener:(context, state) => {
                          if(state is ConfirmPaymentSuccess){
                            Navigator.of(context).pop()
                          },
                        },
                builder: (context, state) {
                  if(state is ConfirmPaymentLoading){
                   return MainBotton(
                    isLoading: true,
                    onTap: null,

                  );
                  }
                     return MainBotton(
                    text: "Confirm Payment",
                    onTap: () {
                      paymentMethodsCubit.confirmPaymentMethod();
                    },
                  );

                  
                 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
