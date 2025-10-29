import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:animation_project/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:animation_project/views/pages/add_new_card_page.dart';
import 'package:animation_project/views/pages/checkout_page.dart';
import 'package:animation_project/views/pages/choose_location_page.dart';
import 'package:animation_project/views/pages/custom_bottom_navbar.dart';
import 'package:animation_project/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );
      case AppRoutes.addNewCardRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => PaymentMethodsCubit(),
                child: const AddNewCardPage(),
              ),
          settings: settings,
        );

      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => const CheckoutPage(),
          settings: settings,
        );
      case AppRoutes.chooseLoacation:
        return MaterialPageRoute(
          builder: (_) => const ChooseLocationPage(),
          settings: settings,
        );

      case AppRoutes.productDetailsRoute:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = ProductDetailsCubit();
                  cubit.getProductDetails(productId);
                  return cubit;
                },
                child: ProductDetailsPage(productId: productId),
              ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
