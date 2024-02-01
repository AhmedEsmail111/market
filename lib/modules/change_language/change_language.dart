import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restart_app/restart_app.dart';

import '../../controller/language/language_cubit.dart';
import '../../controller/language/language_states.dart';
import '../../shared/components/default_button_in_app.dart';
import '../../shared/components/divider_line.dart';
import '../../shared/components/row_like_appbar.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/styles/colors.dart';
import '/modules/change_language/language_tile.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final languageCubit = ShopCubit.get(context);

        return PopScope(
          onPopInvoked: (_) async {
            languageCubit.arabicStatus =
                CacheHelper.getData(key: languageKey) == 'ar' ? true : false;
            languageCubit.englishStatus = !languageCubit.arabicStatus;
          },
          child: Scaffold(
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  BuildRowLikeAppBar(
                    text: locale!.language,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Material(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: borderColor),
                        borderRadius: BorderRadius.circular(14)),
                    color: isDark ? blackColor : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        children: [
                          BuildLanguageTile(
                            text: 'العربية',
                            isClicked: languageCubit.arabicStatus,
                            onClick: (status) {
                              languageCubit.changeLanguageStatus(
                                  !languageCubit.arabicStatus, 1);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: const BuildDividerLine(thickness: 2),
                          ),
                          BuildLanguageTile(
                            text: 'English',
                            isClicked: languageCubit.englishStatus,
                            onClick: (status) {
                              languageCubit.changeLanguageStatus(
                                  !languageCubit.englishStatus, 0);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  BuildDefaultButton(
                    onTap: () {
                      languageCubit.setDefaultLanguage();
                      Restart.restartApp();
                    },
                    text: locale.save_changes,
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 3,
                    context: context,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
