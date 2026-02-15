// signup_screen.dart
// Complete Sign Up Screen with Email/Password Registration

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/common_wigdets/common_button.dart';
import 'package:stress_detection_app/common_wigdets/common_textform_flied.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _agreeToTerms = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(height: 30),

                // Logo
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
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
                      child: Text('🧠', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                ),

                UIHelper.verticalSpace(24.h),

                // Title
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                const Center(
                  child: Text(
                    'Join us to start your mental wellness journey',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                UIHelper.verticalSpace(30.h),
                CommonTextFormField(
                  controller: _nameController, 
                  labelText: 'Full Name', 
                  hintText: 'Enter your full name'
                  ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: _emailController, 
                  labelText: 'Email', 
                  hintText: 'your@email.com'
                  ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: _passwordController, 
                  labelText: 'Password', 
                  hintText: '******',
                  obscureText: true,
                  ),
                UIHelper.verticalSpace(20.h),
                CommonTextFormField(
                  controller: _ageController, 
                  labelText: 'Age (Optional)', 
                  hintText: 'For personalized insights',
                  ),

                UIHelper.verticalSpace(24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF4ECDC4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _agreeToTerms = !_agreeToTerms;
                          });
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                            children: [
                              TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms',
                                style: TextStyle(
                                  color: Color(0xFF4ECDC4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: ' & '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFF4ECDC4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                UIHelper.verticalSpace(30.h),

                // Sign Up Button
                CommonButton(
                  text: 'Sign Up', 
                  onPressed: (){

                  }
                  ),

                UIHelper.verticalSpace(24.h),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                    GestureDetector(
                      onTap: () {
                      
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF4ECDC4),
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