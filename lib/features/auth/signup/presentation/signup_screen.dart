import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/common_wigdets/common_textform_flied.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isRemember = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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
                UIHelper.verticalSpace(20.h),
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: AppColors.cFFFFFF,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Text(
                  "Join us to start your stress-free journey",
                  style: TextStyle(
                    color: AppColors.cFFFFFF.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                ),
                UIHelper.verticalSpace(30.h),
                CommonTextFormField(
                  controller: nameController,
                  label: 'Full Name',
                  hintText: 'Anik Biswas',
                  keyboardType: TextInputType.name,
                  prefixIcon: Image.asset(
                    AssetsIcons.personIcon,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.name,
                  prefixIcon: Image.asset(
                    AssetsIcons.emailIcon,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
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
                UIHelper.verticalSpace(20.h),
                CommonButton(
                  text: 'Sign Up', 
                  onPressed: (){

                  }
                  ),
                UIHelper.verticalSpace(60.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: AppColors.cFFFFFF.withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                      children:  [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(color: AppColors.cFF5A2C),
                        ),
                      ],
                    ),
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
