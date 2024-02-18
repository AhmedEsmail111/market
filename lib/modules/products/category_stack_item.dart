import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/modules/category_products/category_products_screen.dart';
import 'package:shop_app/shared/helper_functions.dart';

import '../../shared/components/image_placeholder.dart';

class BuildCategoryStackItem extends StatelessWidget {
  final Category model;
  const BuildCategoryStackItem({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    final string = model.name.split(' ');

    return GestureDetector(
      onTap: () {
        HelperFunctions.pushScreen(
          context,
          CategoryProductsScreen(
            category: model.name,
            categoryId: model.id,
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.r),
            child: BuildImagePlaceholder(
              image: model.image,
              imageHeight: 75.w,
              imageWidth: 75.w,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            model.id == 43
                ? string[1].toUpperCase()
                : string.first.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
