import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/controller/category_products/category_products_cubit.dart';
import 'package:shop_app/controller/category_products/category_products_states.dart';
import 'package:shop_app/shared/components/back_button.dart';

import '../../shared/components/product_tile.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  final int categoryId;
  const CategoryProductsScreen(
      {super.key, required this.category, required this.categoryId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductsCubit()..getCategoryProducts(categoryId),
      child: BlocConsumer<CategoryProductsCubit, CategoryProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CategoryProductsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(hasBackground: false),
              title: Text(category.toUpperCase()),
            ),
            body: cubit.categoryProductsModel != null
                ? ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: cubit
                        .categoryProductsModel!.searchData.productData.length,
                    itemBuilder: (ctx, index) => BuildProductTile(
                      product: cubit
                          .categoryProductsModel!.searchData.productData[index],

                      // index: index,
                    ),
                    separatorBuilder: (ctx, index) => SizedBox(height: 8.h),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
