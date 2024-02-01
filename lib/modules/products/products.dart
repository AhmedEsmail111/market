import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/helper_functions.dart';

import '../../shared/styles/colors.dart';
import '/controller/home/home_cubit.dart';
import '/controller/home/home_states.dart';
import '/models/home/home_model.dart';
import '/modules/products/category_stack_item.dart';
import '/shared/components/custom_indicator.dart';
import '/shared/components/products_item.dart';
import '/shared/components/slider.dart';

class BuildProducts extends StatelessWidget {
  final HomeModel model;
  BuildProducts({super.key, required this.model});

  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        // print(cubit.favorites.entries.toList().length);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              BuildSlider(
                images: model.data.banners,
                controller: controller,
                onPageChanged: (index, _) {
                  cubit.changeSliderIndex(index);
                },
                height: 150.h,
                width: MediaQuery.of(context).size.width / 1.2,
                viewPort: 0.9,
              ),
              BuildCustomIndicator(
                numberOfIndicators: model.data.banners,
                controller: controller,
                sliderIndex: cubit.sliderIndex,
              ),

              SizedBox(height: 4.h),
              Container(
                padding: HelperFunctions.isLocaleEnglish()
                    ? EdgeInsets.only(left: 16.w)
                    : EdgeInsets.only(right: 16.w),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: isDark
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.pop_categories,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      height: 95.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => BuildCategoryStackItem(
                              model: cubit.categoryModel!.data[index]),
                          separatorBuilder: (ctx, index) =>
                              SizedBox(width: 8.w),
                          itemCount: cubit.categoryModel!.data.length),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              // const BuildDividerLine(),
              Padding(
                padding: HelperFunctions.isLocaleEnglish()
                    ? EdgeInsets.only(left: 4.w)
                    : EdgeInsets.only(right: 4.w),
                child: Text(
                  locale.lat_Products,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20.sp),
                ),
              ),

              GridView.builder(
                  itemCount: model.data.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.w,
                      childAspectRatio: 1 / 1.34),
                  itemBuilder: (ctx, index) => BuildProductsItem(
                        product: model.data.products[index],
                        onTap: () {},
                        index: index,
                      ))
            ],
          ),
        );
      },
    );
  }
}
