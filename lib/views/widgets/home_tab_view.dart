import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/home_cubit/home_cubit.dart';
import 'package:animation_project/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
 
      if(state is HomeLoading){
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if( state is HomeLoaded){
        return SingleChildScrollView(
          child: Column(
            children: [
              FlutterCarousel.builder(
                itemCount: state.carouselItems.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              state.carouselItems[itemIndex].imgUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                options: FlutterCarouselOptions(
                  height: 200,
                  showIndicator: true,
                  autoPlay: true,
                  slideIndicator: CircularStaticIndicator(),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New Arrivals",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "See All",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.product.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell (
                    onTap: ()=>Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.productDetailsRoute,arguments: state.product[index].id),
                    child: ProductItem(productItem: state.product[index]));
                },
              ),
            ],
          ),
        );
      }
      else if(state is HomeError){
        return Center(
          child: Text(state.message,
          style: Theme.of(context).textTheme.labelLarge,),
        );
      }
      else{return const SizedBox.shrink();}

       
      },
    );
  }
}
