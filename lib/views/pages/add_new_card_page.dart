import 'package:animation_project/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/views/widgets/label_with_textfield_new_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddNewCardCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Add New Card")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LabelWithTextfieldNewCard(
                          label: "Card Number",
                          icon: Icons.credit_card,
                          hintText: "Enter card number",
                          controller: _cardNumberController,
                        ),
                        const SizedBox(height: 24),

                        LabelWithTextfieldNewCard(
                          label: "Card Holder Name",
                          icon: Icons.person,
                          hintText: "Enter card holder name",
                          controller: _cardHolderController,
                        ),
                        const SizedBox(height: 24),

                        LabelWithTextfieldNewCard(
                          label: "Expiry Date",
                          icon: Icons.calendar_month,
                          hintText: "Enter expiry date",
                          controller: _expiryDateController,
                        ),
                        const SizedBox(height: 24),

                        LabelWithTextfieldNewCard(
                          label: "CVV",
                          icon: Icons.lock,
                          hintText: "Enter CVV",
                          controller: _cvvController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                  bloc: cubit,
                  listenWhen:(previous, current) => current is AddNewCardFailure|| current is AddNewCardSuccess ,
                  listener: (context, state){
                    if(state is AddNewCardSuccess){
                      Navigator.pop(context);
                    }
                    else if(state is AddNewCardFailure){
                       ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                    }
                  }
                   ,
                  buildWhen:
                      (previous, current) =>
                          current is AddNewCardFailure ||
                          current is AddNewCardSuccess ||
                          current is AddNewCardLoading,
                  builder: (context, state) {
                    if (state is AddNewCardLoading) {
                      return const ElevatedButton(
                        onPressed: null,
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.addNewCard(
                            _cardNumberController.text,
                           _cardHolderController.text,
                            _expiryDateController.text,
                             _cvvController.text);
                        }

                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: AppColor.white,
                      ),
                      child: const Text(
                        "Add Card",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
