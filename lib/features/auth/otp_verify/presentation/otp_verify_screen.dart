import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart' hide PinTheme;
import 'package:pinput/pinput.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 71.w,
      height: 71.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
        borderRadius: BorderRadius.circular(83.r),
        border: Border.all(color: AppColors.cFFFFFF.withOpacity(0.2)),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(32.h),
                Text(
                  "OTP",
                  style: TextStyle(
                    color: AppColors.cFFFFFF,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  'Please enter the OTP we have sent you in your Email',
                  style: TextStyle(
                    color: AppColors.cFFFFFF.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                ),
                UIHelper.verticalSpace(43.h),
                Pinput(
                  length: 4,
                  // controller: _otpController,
                  // validator: validate4DigitPinCode,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(60.h),
                CommonButton(text: 'Verify', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
