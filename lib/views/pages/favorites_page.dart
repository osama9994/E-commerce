import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // Load favorites when page is first initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favoriteCubit = context.read<FavoriteCubit>();
      // Only load if not already loading or loaded
      if (favoriteCubit.state is! FavoriteLoading && favoriteCubit.state is! FavoriteLoaded) {
        favoriteCubit.getFavoriteProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: favoriteCubit,
      buildWhen:
          (previous, current) =>
              current is FavoriteLoading ||
              current is FavoriteLoaded ||
              current is FavoriteError,
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is FavoriteLoaded) {
          final favoriteProducts = state.favoriteProducts;
          if (favoriteProducts.isEmpty) {
            return const Center(child: Text("No favorite products found."));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await favoriteCubit.getFavoriteProducts();
            },
            child: ListView.separated(
              separatorBuilder:
                  (context, index) =>
                      Divider(indent: 20, endIndent: 20, color: AppColor.grey2),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imgUrl),
                    radius: 25,
                  ),
                  trailing: BlocConsumer<FavoriteCubit, FavoriteState>(
                      bloc: favoriteCubit,
                      listenWhen: (previous, current) => current is FavoriteRemoveError,
                    listener: (context, state) {
                      if(state is FavoriteRemoveError){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:Text("Error removing favorite: ${state.error}"))
                        );
                      }
                    },
                  
                    buildWhen: (previous, current) =>
                        (current is FavoriteRemoving && current.productId == product.id) ||
                        (current is FavoriteRemoved && current.productId == product.id) ||
                        current is FavoriteRemoveError,
                    builder: (context, state) { 
                      if(state is FavoriteRemoving && state.productId == product.id){
                        return const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                        );
                      }
                      return IconButton(
                        icon: const Icon(Icons.delete, color: AppColor.red),
                        onPressed: () async {
                          await favoriteCubit.removeFavoriteProduct(product.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is FavoriteError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
