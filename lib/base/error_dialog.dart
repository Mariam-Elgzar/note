import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'base_state.dart';

enum DialogIcon {
  error('assets/images/ic_error.svg'),
  warning('assets/images/ic_warning.svg');

  final String value;

  const DialogIcon(this.value);
}

class ErrorDialog extends StatelessWidget {
  final BaseError error;

  const ErrorDialog({
    required this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      content: SizedBox(
        width: 288.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(error.type == ErrorType.validationError
                ? DialogIcon.warning.value
                : DialogIcon.error.value),
            SizedBox(height: 20.h),
            SizedBox(
              width: 256.w,
              child: Text(
                error.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 122.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "close".tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
