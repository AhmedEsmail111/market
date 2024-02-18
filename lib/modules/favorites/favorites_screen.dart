import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/controller/favorites/favorites_cubit.dart';
import 'package:shop_app/controller/favorites/favorites_states.dart';
import 'package:shop_app/shared/components/product_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // draw the favorites items
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: (ctx, state) {},
      builder: (context, state) {
        final cubit = FavoritesCubit.get(context);
        return Scaffold(
          body: cubit.favoritesModel != null
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8),
                  itemCount: cubit.favoritesModel!.data.length,
                  itemBuilder: (ctx, index) => BuildProductTile(
                    product: cubit.favoritesModel!.data[index].product,
                    // index: index,
                  ),
                  separatorBuilder: (ctx, index) => SizedBox(height: 8.h),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
