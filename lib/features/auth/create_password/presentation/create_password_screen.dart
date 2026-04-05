import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/common_wigdets/common_textform_flied.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class CreatePasswordScreen extends StatelessWidget {
   CreatePasswordScreen({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                Text('Create New Password',
                style: TextStyle(
                    color: AppColors.cFFFFFF,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Text("You're almost done! Set a new password to finish\nresetting.",
                style: TextStyle(
                    color: AppColors.cFFFFFF.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                ),
                UIHelper.verticalSpace(60.h),
                CommonTextFormField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Create password',
                  keyboardType: TextInputType.visiblePassword, 
                  isPassword: true,
                  prefixIcon: Image.asset(
                    AssetsIcons.lockIcon,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  keyboardType: TextInputType.visiblePassword, 
                  isPassword: true,
                  prefixIcon: Image.asset(
                    AssetsIcons.lockIcon,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
                UIHelper.verticalSpace(30.h),
                CommonButton(
                  text: 'Sign In', 
                  onPressed: (){

                  }
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
