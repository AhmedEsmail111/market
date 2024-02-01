import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '/controller/settings/settings_cubit.dart';
import '/controller/settings/settings_states.dart';
import '/modules/settings/settings%20_options_card.dart';
import '/modules/settings/settings_tile.dart';
import '/modules/settings/user_info_card.dart';
import '/shared/constants/constants.dart';
import '/shared/network/local/shared_preference.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    // ProfileCubit.get(context)
    //     .getIdentityUser(token: CacheHelper.getData(key: AppConstant.token));

    SettingsCubit.get(context).getUser();
// // check if the there is a token stored before making the jwt request
//     ProfileCubit.get(context)
//         .setUser(CacheHelper.getData(key: AppConstant.token));

    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = SettingsCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20.h, bottom: 16.h, left: 16.w, right: 16.w),
                child: Column(
                  children: [
                    Text(
                      locale.account,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),

                    Stack(
                      children: [
                        CircleAvatar(
                            radius: 40.w,
                            // backgroundColor:
                            //     const Color.fromARGB(255, 240, 236, 236),
                            child:
                                //  Image.asset(
                                //             ,
                                //             fit: BoxFit.cover,
                                //             width: 85.w,
                                //             height: 85.w,
                                //           )
                                //         : Image.asset(
                                //             ImageConstant.userFemaleImage,
                                //             fit: BoxFit.cover,
                                //             width: 85.w,
                                //             height: 85.w,
                                //           )
                                //     :
                                Icon(
                              Icons.person,
                              size: 35.w,
                            )),
                        Positioned(
                          right: 0,
                          bottom: 5,
                          child: Icon(
                            Icons.verified,
                            size: 24.w,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),

                    Text(
                      CacheHelper.getData(key: userName),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),

                    Text(
                      CacheHelper.getData(key: userEmail),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color:
                              isDark ? Colors.grey : const Color(0xFF747474)),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // if (profileCubit.hasAccount)
                    const BuildUserInfoCard(),
                    SizedBox(
                      height: 8.h,
                    ),
                    const BuildSettingsOptionsCard(),
                    SizedBox(
                      height: 12.h,
                    ),
                    // if (profileCubit.hasAccount)
                    Card(
                      color: isDark ? blackColor : Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                            color: isDark ? blackColor : Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: BuildSettingsTile(
                          icon: Icons.logout,
                          iconColor: Theme.of(context).colorScheme.error,
                          text: locale.log_out,
                          withSwitchIcon: false,
                          onClick: () {
                            SettingsCubit.get(context).logout(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
