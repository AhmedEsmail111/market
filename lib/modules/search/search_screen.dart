import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/components/back_button.dart';

import '../../shared/components/default_text_form_in_app.dart';
import '../../shared/components/product_tile.dart';
import '/controller/search/search_cubit.dart';
import '/controller/search/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
              appBar: AppBar(
                leading: const BuildBackButton(),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 55.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Expanded(
                                child: BuildDefaultTextField(
                                  controller: searchController,
                                  inputType: TextInputType.text,
                                  withText: false,
                                  hintText:
                                      'search about any thing you want...',
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
                                    if (searchController.text
                                        .trim()
                                        .isNotEmpty) {
                                      cubit
                                          .search(searchController.text.trim());
                                    }
                                  },
                                  child: Text(
                                    'Search',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ))
                            ],
                          ),
                        ),
                        if (state is LoadingSearchState)
                          SizedBox(
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
                              padding: EdgeInsets.only(top: 8.h),
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
                      ],
                    ),
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
