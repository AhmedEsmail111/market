import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/default_text_form_in_app.dart';
import '../../shared/components/product_tile.dart';
import '/controller/search/search_cubit.dart';
import '/controller/search/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final searchController = TextEditingController();
    // final locale = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (ctx) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SearchCubit.get(context);
          return PopScope(
            onPopInvoked: (_) {
              if (cubit.searchModel != null) {
                cubit.searchModel = null;
              }
            },
            child: Scaffold(
              // appBar: AppBar(
              //   leading: const BuildBackButton(),
              // ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                  ]
                                : [
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.9),
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14.r),
                            bottomRight: Radius.circular(14.r),
                          ),
                        ),
                        padding: EdgeInsets.only(
                            top: 24.h, bottom: 8.h, right: 8.w, left: 8.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Expanded(
                              child: BuildDefaultTextField(
                                isDarkWanted: false,
                                controller: searchController,
                                inputType: TextInputType.text,
                                withText: false,
                                hintText: 'search about any thing you want...',
                                backGroundColor: Colors.white,
                                context: context,
                                width: double.infinity,
                                height: 60.h,
                                maxLength: 100,
                                isObscured: false,
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    cubit.search(value);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            TextButton(
                                onPressed: () {
                                  if (searchController.text.trim().isNotEmpty) {
                                    cubit.search(searchController.text.trim());
                                  }
                                },
                                child: Text(
                                  'Search',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.deepOrangeAccent,
                                      ),
                                ))
                          ],
                        ),
                      ),
                      if (state is LoadingSearchState)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (cubit.searchModel != null &&
                          state is! LoadingSearchState)
                        // Text(
                        //     '${cubit.searchModel!.searchData.productData.first.id.toString()}  ${HomeCubit.get(context).favorites.keys.toList()}')
                        Expanded(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(16.w),
                            itemCount: cubit
                                .searchModel!.searchData.productData.length,
                            itemBuilder: (ctx, index) => BuildProductTile(
                              product: cubit
                                  .searchModel!.searchData.productData[index],
                              // index: index,
                            ),
                            separatorBuilder: (ctx, index) =>
                                SizedBox(height: 8.h),
                          ),
                        ),
                      if (cubit.searchModel != null &&
                          state is! LoadingSearchState &&
                          cubit.searchModel!.searchData.productData.isEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: Text(
                              'No results match your search criteria!',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
