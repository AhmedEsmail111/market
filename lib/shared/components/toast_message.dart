import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void buildToastMessage({
  required String message,
  required ToastGravity gravity,
  required Color textColor,
  required Color background,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 5,
    backgroundColor: background,
    textColor: textColor,
    fontSize: 16.sp,
  );
}
