import 'package:animation_project/models/payment_cart_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.paymentCard,
    required this.onItemTapped,
  });
  final PaymentCardModel paymentCard;
  final VoidCallback onItemTapped;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTapped,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.white,
          border: Border.all(color: AppColor.grey3),
        ),
        child: ListTile(
          leading: Image.asset(
            "images/mastercard_logo.png",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          title: Text("MasterCard"),
          subtitle: Text(paymentCard.cardNumber),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
