import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/categories/categories_model.dart';

import '../../shared/components/image_placeholder.dart';

class BuildCategoryTile extends StatelessWidget {
  final Data model;
  final void Function()? onClicked;
  const BuildCategoryTile({
    super.key,
    required this.model,
    this.onClicked,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            BuildImagePlaceholder(
              image: model.image,
              imageHeight: 100.h,
              imageWidth: 100.h,
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              model.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 16.sp),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: const Icon(
                Icons.arrow_forward_ios,
              ),
            )
          ],
        ),
      ),
    );
  }
}
