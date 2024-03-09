// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:united_proposals_app/utils/app_colors.dart';

class AppTextFormField extends StatefulWidget {
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
  final bool obscureText;
  final bool readOnly;

  final String? Function(String?)? onSaved;

  const AppTextFormField(
      {Key? key,
      this.onSaved,
      this.maxLines,
      this.maxLength,
      this.controller,
      required this.hintText,
      this.initialVal,
      this.validator,
      this.suffixIcon,
      this.inputAction,
      this.inputType,
      this.onTap,
      this.obscureText = true,
      this.focusNode,
      this.onChanged,
      this.fieldTitle = "",
      this.readOnly = false})
      : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldTitle != "")
            Container(
              margin: const EdgeInsets.only(left: 4, top: 15, bottom: 5),
              child: Text(
                widget.fieldTitle ?? "",
              ),
            ),
          TextFormField(
            onSaved: widget.onSaved,
            maxLength: widget.maxLength,
            initialValue: widget.initialVal,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            validator: widget.validator,
            onTap: widget.onTap,
            controller: widget.controller,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              isDense: true,
              fillColor: AppColors.primary.withOpacity(.1),
              filled: true,
              focusColor: Colors.red,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              focusedErrorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
