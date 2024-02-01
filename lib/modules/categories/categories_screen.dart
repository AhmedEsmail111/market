import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/controller/home/home_cubit.dart';
import 'package:shop_app/controller/home/home_states.dart';
import 'package:shop_app/modules/categories/category_tile.dart';
import 'package:shop_app/modules/category_products/category_products_screen.dart';
import 'package:shop_app/shared/helper_functions.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Scaffold(
          body: cubit.categoryModel != null
              ? ListView.separated(
                  padding: EdgeInsets.only(top: 8.h),
                  itemCount: cubit.categoryModel!.data.length,
                  itemBuilder: (ctx, index) => BuildCategoryTile(
                    model: cubit.categoryModel!.data[index],
                    onClicked: () {
                      HelperFunctions.pushScreen(
                        context,
                        CategoryProductsScreen(
                          category: cubit.categoryModel!.data[index].name,
                          categoryId: cubit.categoryModel!.data[index].id,
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (ctx, index) => const Divider(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
