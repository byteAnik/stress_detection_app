


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/constants/text_font_style.dart';
import 'package:stress_detection_app/helpers/ui_helpers.dart';

class CommontextFormflied extends StatefulWidget {
  final FocusNode? focusNode;
  final String label;
  final String hintText;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final bool showCursor;
  final Function(String)? onChanged;


  const CommontextFormflied({
  super.key,
    this.focusNode,
    required this.hintText,
     required this.label,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.showCursor = true,
    this.onChanged,
  });

  @override
  State<CommontextFormflied> createState() => _CommontextFormfliedState();
}

class _CommontextFormfliedState extends State<CommontextFormflied> {
  late bool _isObscured;
  bool? _isPasswordValid;

  final RegExp _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Color _getBorderColor() {
    if (!widget.isPassword || _isPasswordValid == null) {
      return AppColors.cDFDFDF;
    }
    return _isPasswordValid! ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextFontStyle.textStylec24cRobotoW600.copyWith(
            color: AppColors.c333333,
            fontSize: 16.sp,
             fontWeight: FontWeight.w400,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        TextFormField(
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscured : widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          showCursor: widget.showCursor,
          onChanged: (value) {
            if (widget.isPassword) {
              setState(() {
                _isPasswordValid = _passwordRegex.hasMatch(value);
              });
            }
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextFontStyle.textStylec24cRobotoW600.copyWith(
              color: AppColors.cBEBEBE,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.cFFFFFF,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: _getBorderColor()),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: _getBorderColor()),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: widget.isPassword
                    ? _getBorderColor()
                    : AppColors.c333333,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _isObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.c5D5D5D,
                        ),
                        onPressed: _toggleVisibility,
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}

