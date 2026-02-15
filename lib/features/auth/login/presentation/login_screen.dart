// login_screen.dart
// Complete Login Screen with Email/Password and Social Login

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/common_wigdets/common_textform_flied.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/features/auth/signup/presentation/signup_screen.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    // text: '01305032297',
  );
  final TextEditingController _passwordController = TextEditingController(
    // text: '01305032297',
  );
  


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: UIHelper.kDefaulutPadding()),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(40.h),

                // Logo
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFA7C7E7).withOpacity(0.4),
                          const Color(0xFF4ECDC4).withOpacity(0.4),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text('🧠', style: TextStyle(fontSize: 45)),
                    ),
                  ),
                ),

                UIHelper.verticalSpace(30.h),

                // Title
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                const Text(
                  'Log in to continue your wellness journey',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF666666),
                  ),
                ),

                UIHelper.verticalSpace(40.h),

                // Email Field
                CommonTextFormField(
                  controller: _emailController, 
                  labelText: 'Email', 
                  hintText: 'Enter your email',
                  
                ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: _passwordController, 
                  labelText: 'Password', 
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF4ECDC4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                UIHelper.verticalSpace(30.h),

                // Login Button
                CommonButton(
                  text: 'LogIn', 
                  onPressed: (){
                    Get.to(()=>SignUpScreen());
                  }
                  ),

                 UIHelper.verticalSpace(30.h),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xFFDDDDDD))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Color(0xFFDDDDDD))),
                  ],
                ),

                UIHelper.verticalSpace(30.h),

                // Google Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed:(){

                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDDDDDD), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('🔍', style: TextStyle(fontSize: 24)),
                        SizedBox(width: 12),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                UIHelper.verticalSpace(16.h),

                // Apple Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed:(){

                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDDDDDD), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('🍎', style: TextStyle(fontSize: 24)),
                        SizedBox(width: 12),
                        Text(
                          'Continue with Apple',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                UIHelper.verticalSpace(30.h),

                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                    GestureDetector(
                      onTap: () {
                      
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.c4ECDC4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}