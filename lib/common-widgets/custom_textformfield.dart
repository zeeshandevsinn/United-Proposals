import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldTitle;
  final String hintText;
  final String? initialVal;
  final String? Function(String?)? validator;
  final String Function(String)? onChanged;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? readOnly;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.fieldTitle,
      required this.hintText,
      this.initialVal,
      this.validator,
      this.onChanged,
      this.onTap,
      this.suffixIcon,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.maxLines = 1,
      this.maxLength,
      this.autovalidateMode,
      this.obscureText = false,
      this.readOnly = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.fieldTitle?.isNotEmpty ?? false)
          Container(
            margin: EdgeInsets.only(left: 4.sp, bottom: 4.sp, top: 6.sp),
            child: Text(
              widget.fieldTitle ?? "",
              style: AppTextStyles.poppinsMedium(
                fontSize: 11.sp,
                color: Colors.black,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          initialValue: widget.initialVal,
          readOnly: widget.readOnly ?? false,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged ??
              (val) {
                setState(() {});
              },
          validator: widget.validator,
          onTap: widget.onTap,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autovalidateMode,
          style: AppTextStyles.poppinsRegular(
            fontSize: 11.sp,
            color: Colors.black,
          ),
          decoration: AppDecoration.fieldDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
