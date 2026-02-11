import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(400.w),
                Center(
                  child: Text('Nazmul khakirpola',
                  style: TextStyle(
                    color: Colors.black,
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
