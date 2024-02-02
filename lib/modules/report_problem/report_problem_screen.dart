import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/controller/complaint/complaint_cubit.dart';
import 'package:shop_app/controller/complaint/complaint_states.dart';
import 'package:shop_app/shared/components/default_button_in_app.dart';
import 'package:shop_app/shared/components/default_text_form_in_app.dart';
import 'package:shop_app/shared/components/toast_message.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';

import '/shared/components/row_like_appbar.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    // final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ComplaintCubit(),
      child: BlocConsumer<ComplaintCubit, ComplaintStates>(
        listener: (context, state) {
          if (state is AddComplaintSuccessState) {
            buildToastMessage(
              message:
                  CacheHelper.getData(key: AppConstants.languageKey) == 'ar'
                      ? 'شكرا لمساعدتنا عل جعل الماركت مكانا امنا'
                      : 'Thanks for helping us mak Market a safe place',
              gravity: ToastGravity.BOTTOM,
              textColor: Theme.of(context).colorScheme.onSecondary,
              background:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            );
          }
        },
        builder: (context, state) {
          final cubit = ComplaintCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Form(
                  // key: formKey,
                  child: Column(
                    children: [
                      BuildRowLikeAppBar(text: locale.report_problem),
                      SizedBox(height: 24.h),
                      Text(
                        locale.report_message,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                      ),
                      SizedBox(height: 16.h),
                      BuildDefaultTextField(
                        autoFocus: true,
                        inputType: TextInputType.text,
                        hintText: '',
                        onChange: (value) {
                          cubit.changeComplaint(value);
                        },
                        aboveFieldText: locale.enter_complaint,
                        backGroundColor: Colors.white,
                        context: context,
                        width: double.infinity,
                        height: 50.h,
                        maxLength: 300,
                        isObscured: false,
                        maxLines: 3,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return CacheHelper.getData(
                                        key: AppConstants.languageKey) ==
                                    'ar'
                                ? 'أدخل المشكلة من فضلك'
                                : 'please enter your Compliant';
                          }
                        },
                        onSaved: (value) {
                          cubit.complaint = value!;
                        },
                        onSubmitted: (value) {
                          if (cubit.complaint.trim().isNotEmpty) {
                            cubit.addComplaint(cubit.complaint);
                          }
                        },
                      ),
                      SizedBox(height: 24.h),
                      cubit.isAddingComplaint
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : BuildDefaultButton(
                              onTap: cubit.complaint.trim().isEmpty
                                  ? null
                                  : () {
                                      cubit.addComplaint(cubit.complaint);
                                    },
                              text: locale.report,
                              elevation: 2,
                            ),
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
