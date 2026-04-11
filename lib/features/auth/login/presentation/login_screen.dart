import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/common_wigdets/common_textform_flied.dart';
import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/auth/otp_verify/presentation/otp_verify_screen.dart';
import 'package:stress_detection_app/features/auth/signup/presentation/signup_screen.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRemember = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B0F,
      resizeToAvoidBottomInset: true, // 🔥 keyboard safe
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
                  "Welcome Back",
                  style: TextStyle(
                    color: AppColors.cFFFFFF,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpace(6.h),
                Text(
                  "Sign in to continue monitoring your stress.",
                  style: TextStyle(
                    color: AppColors.cFFFFFF.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                ),
                UIHelper.verticalSpace(30.h),
                CommonTextFormField(
                  controller: emailController,
                  label: 'Email or Phone',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
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
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  prefixIcon: Image.asset(
                    AssetsIcons.lockIcon,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                      child: Container(
                        height: 18.h,
                        width: 18.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color:
                                isRemember
                                    ? AppColors.cFF5A2C
                                    : AppColors.cFFFFFF.withOpacity(0.3),
                          ),
                          color:
                              isRemember
                                  ? AppColors.cFF5A2C
                                  : Colors.transparent,
                        ),
                        child:
                            isRemember
                                ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: AppColors.cFFFFFF,
                                )
                                : null,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        color: AppColors.cFFFFFF.withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(), // ✅ THIS is OK (Row e allowed)
                    GestureDetector(
                      onTap: () {
                        Get.to(() => OtpVerifyScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.cFF5A2C,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                UIHelper.verticalSpace(25.h),
                CommonButton(text: 'Sing In', onPressed: () {}),
                UIHelper.verticalSpace(25.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.cFFFFFF.withOpacity(0.2)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: AppColors.cFFFFFF.withOpacity(0.5),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: AppColors.cFFFFFF.withOpacity(0.2)),
                    ),
                  ],
                ),

                UIHelper.verticalSpace(20.h),

                /// 🔥 Social Buttons
                Row(
                  children: [
                    Expanded(child: _social("Google", Icons.g_mobiledata)),
                    SizedBox(width: 12.w),
                    Expanded(child: _social("Apple", Icons.apple)),
                  ],
                ),

                /// 🔥 REMOVE Spacer → use fixed space
                UIHelper.verticalSpace(40.h),

                /// 🔥 Bottom Text
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignupScreen());
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.cFFFFFF.withOpacity(0.6),
                          fontSize: 12.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "Create Account",
                            style: TextStyle(color: AppColors.cFF5A2C),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _social(String text, IconData icon) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 6.w),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 13.sp)),
        ],
      ),
    );
  }
}
