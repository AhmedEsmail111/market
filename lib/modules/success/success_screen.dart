import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/layout/shop_layout.dart';
import '/shared/components/default_button_in_app.dart';
import '/shared/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    'assets/images/success.gif',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 180.h,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  locale.successful_payment,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 150.w,
                  child: BuildDefaultButton(
                    elevation: 2,
                    onTap: () {
                      HelperFunctions.pussAndRemoveAll(
                        context,
                        const ShopLayout(),
                      );
                    },
                    text: locale.go_on,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
