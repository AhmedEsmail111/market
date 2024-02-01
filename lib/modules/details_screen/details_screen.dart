import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/slider.dart';
import '../../shared/styles/colors.dart';
import '/controller/details_screen/details_screen_cubit.dart';
import '/controller/details_screen/details_screen_states.dart';
import '/models/home/home_model.dart';
import '/modules/details_screen/arrow_back.dart';
import '/modules/details_screen/draggable_container.dart';
import '/shared/components/custom_indicator.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    // print(product.id);
    final controller = CarouselController();
    return BlocProvider(
      create: (context) => DetailsScreenCubit(),
      child: BlocConsumer<DetailsScreenCubit, DetailsScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = DetailsScreenCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    BuildSlider(
                      images: product.images,
                      controller: controller,
                      onPageChanged: (index, _) {
                        cubit.changeSliderIndex(index);
                      },
                      height: 280.h,
                      width: MediaQuery.of(context).size.width,
                      viewPort: 1.0,
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      top: 275,
                      child: Center(
                        child: BuildCustomIndicator(
                          numberOfIndicators: product.images,
                          controller: controller,
                          sliderIndex: cubit.sliderIndex,
                          smoothColor: 0.6,
                        ),
                      ),
                    ),
                    const BuildArrowBack(),
                    BuildDraggableContainer(
                      product: product,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
