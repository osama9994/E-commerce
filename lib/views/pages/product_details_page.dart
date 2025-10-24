import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:animation_project/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});


  final String productId;
  @override
  Widget build(BuildContext context) {
    //final size=MediaQuery.of(context).size;
    final cubit=BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen:
          (previous, current) =>
              current is ProductDetailsLoading || current is ProductDetailsLoaded || current is ProductDetailsError ,
      bloc: cubit,
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Product Details"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.52,
                  decoration: BoxDecoration(color: AppColor.grey2),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Image.asset(
                        product.imgUrl,
                        height: size.height * 0.4,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.47),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppColor.yellow,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        product.averageRate.toString(),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: BlocProvider.of<ProductDetailsCubit>(
                                  context,
                                ),
                                buildWhen:
                                    (previous, current) =>
                                        current is QuantityCounterLoaded ||
                                        current is ProductDetailsLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounterLoaded) {
                                    return CounterWidget(
                                      productId: product.id,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                      value: state.value,
                                    );
                                  } else if (state is ProductDetailsLoaded) {
                                    return CounterWidget(
                                      productId: product.id,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                      value:1,
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "size",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: cubit,
                            buildWhen:
                                (previous, current) =>
                                    current is SizeSelected ||
                                    current is ProductDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children:
                                    ProductSize.values
                                        .map(
                                          (size) => Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6.0,
                                              right: 8.0,
                                            ),
                                            child: InkWell(
                                              onTap:
                                                  () {
                                                    if(state is SizeSelected){

                                                    }
                                                    BlocProvider.of<
                                                    ProductDetailsCubit
                                                  >(context).selectedSize(size);
                                                  },
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      state is SizeSelected &&
                                                              state.size == size
                                                          ? Theme.of(
                                                            context,
                                                          ).primaryColor
                                                          : AppColor.grey2,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child: Text(
                                                    size.name,
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.labelMedium!.copyWith(
                                                      color:
                                                          state is SizeSelected &&
                                                                  state.size == size
                                                              ? AppColor.white
                                                              : AppColor.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: AppColor.black45),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.price}",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                                bloc: cubit,
                                buildWhen:(previous, current) => current is ProductAddedToCart || current is ProductAddingToCart ,
                                builder: (context, state) {
                                  if(state is ProductAddingToCart){
                                    return ElevatedButton(
                                    onPressed:null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary,
                                      foregroundColor: AppColor.white,
                                    ),
                                  child:const CircularProgressIndicator.adaptive(),
                                  );

                                  }
                                  else if(state is ProductAddedToCart){
                                    return ElevatedButton(
                                    onPressed:null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary,
                                      foregroundColor: AppColor.white,
                                    ),
                                  child:const Text("Added To Cart"),
                                  );

                                  }
                                  return ElevatedButton.icon(
                                    onPressed:
                                        () {
                                          if(cubit.selectedsize  !=null){
                                            cubit.addToCart(product.id);
                                           
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select size")));
                                          }
                                        
                                        },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primary,
                                      foregroundColor: AppColor.white,
                                    ),
                                    icon: const Icon(
                                      Icons.shopping_bag_outlined,
                                      color: AppColor.white,
                                    ),
                                    label: const Text("Add to Cart"),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("Something went Wrong!")),
          );
        }
      },
    );
  }
}
