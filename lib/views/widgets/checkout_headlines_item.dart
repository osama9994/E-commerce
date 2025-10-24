// import 'package:flutter/material.dart';

// class CheckoutHeadlinesItem extends StatelessWidget {
//   const CheckoutHeadlinesItem({
//     super.key,
//     required this.title,
//     this.namOfProduct,
//     this.onTap,
//   });
//   final String title;
//   final VoidCallback? onTap;
//   final int? namOfProduct;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(title, style: Theme.of(context).textTheme.titleLarge),
//             if (namOfProduct != 0)
//               Text(
//                 "($namOfProduct)",
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//           ],
//         ),

//         if (onTap != null)
//           TextButton(onPressed: () {}, child: const Text("Edit")),
//       ],
//     );
//   }
// }
 

 import 'package:flutter/material.dart';

class CheckoutHeadlinesItem extends StatelessWidget {
  const CheckoutHeadlinesItem({
    super.key,
    required this.title,
    this.namOfProduct,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;
  final int? namOfProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (namOfProduct != null && namOfProduct != 0)
              Text(
                " (${namOfProduct.toString()})",
                style: Theme.of(context).textTheme.titleLarge,
              ),
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text("Edit"),
          ),
      ],
    );
  }
}
