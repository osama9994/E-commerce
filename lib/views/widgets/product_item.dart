import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productItem});
  final ProductItemModel productItem;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      buildWhen: (previous, current) =>
          current is HomeLoaded ||
          current is HomeLoading ||
          current is HomeError,
      builder: (context, state) {
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
                    child: CachedNetworkImage(
                      imageUrl: productItem.imgUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen: (previous, current) =>
                        (current is SetFavoriteLoading &&
                            current.productId == productItem.id) ||
                        (current is SetFavoriteSuccess &&
                            current.productId == productItem.id) ||
                        (current is SetFavoriteFailed &&
                            current.productId == productItem.id),
                    builder: (context, state) {
                      if (state is SetFavoriteLoading &&
                          state.productId == productItem.id) {
                        return const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                          ),
                        );
                      }

                      bool isFavorite = productItem.isFavorite;
                      if (state is SetFavoriteSuccess &&
                          state.productId == productItem.id) {
                        isFavorite = state.isFavorite;
                      }
                      return InkWell(
                        onTap: () => homeCubit.setFavorite(productItem),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              productItem.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              productItem.category,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            Text(
              '\$${productItem.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        );
      },
    );
  }
}



// import 'package:animation_project/models/product_item_model.dart';
// import 'package:animation_project/utils/app_color.dart';
// import 'package:animation_project/view_models/home_cubit/home_cubit.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductItem extends StatelessWidget {
//   const ProductItem({super.key, required this.productItem});
//   final ProductItemModel productItem;
//   @override
//   Widget build(BuildContext context) {
//     final homeCubit = BlocProvider.of<HomeCubit>(context);
//     return BlocBuilder<HomeCubit, HomeState>(
//       bloc: BlocProvider.of<HomeCubit>(context),
//       buildWhen:
//           (previous, current) =>
//               current is HomeLoaded ||
//               current is HomeLoading ||
//               current is HomeError,
//       builder: (context, state) {
//         return Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 120,
//                   width: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: AppColor.grey2,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(productItem.imgUrl, fit: BoxFit.contain),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,

//                   child: DecoratedBox(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white54,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: BlocBuilder<HomeCubit, HomeState>(
//                         bloc: homeCubit,
//                         buildWhen:
//                             (previous, current) =>
//                                 current is SetFavoriteLoading && current.productId == productItem.id ||
//                                 current is SetFavoriteSuccess && current.productId == productItem.id ||
//                                 current is SetFavoriteFailed && current.productId == productItem.id ,
//                         builder: (context, state) {
//                           if (state is SetFavoriteLoading) {
//                             return const SizedBox(
//                               height: 24,
//                               width: 24,
//                               child: CircularProgressIndicator.adaptive(),
//                             );
//                           } else if (state is SetFavoriteSuccess) {
//                             return state.isFavorite
//                                 ? InkWell(
//                                   onTap:
//                                       () async => await homeCubit.setFavorite(
//                                         productItem,
//                                       ),
//                                   child: const Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                   ),
//                                 )
//                                 : InkWell(
//                                   onTap:
//                                       () async => await homeCubit.setFavorite(
//                                         productItem,
//                                       ),
//                                   child: const Icon(Icons.favorite),
//                                 );
//                           }
//                           return InkWell(
//                             onTap:
//                                 () async =>
//                                     await homeCubit.setFavorite(productItem),
//                             child:
//                                 productItem.isFavorite
//                                     ? Icon(Icons.favorite, color: Colors.red)
//                                     : Icon(Icons.favorite_border),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(
//               productItem.name,
//               style: Theme.of(
//                 context,
//               ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
//             ),
//             Text(
//               productItem.category,
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//               ),
//             ),
//             Text(
//               '\$${productItem.price}',
//               style: Theme.of(
//                 context,
//               ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
