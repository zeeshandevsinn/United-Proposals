import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:united_proposals_app/utils/app_colors.dart';

class OTPField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const OTPField({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        focusNode: widget.focusNode,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 45,
          fieldWidth: 45,
          errorBorderColor: AppColors.primary,
          inactiveFillColor: AppColors.white,
          inactiveColor: AppColors.primary,
          selectedColor: AppColors.primary,
          selectedFillColor: AppColors.white,
          activeFillColor: AppColors.white,
          activeColor: AppColors.primary,
        ),
        animationDuration: const Duration(milliseconds: 300),
        cursorColor: AppColors.primary,
        enableActiveFill: true,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        hintCharacter: "0",
        onCompleted: (v) {},
        onChanged: (value) {
          setState(() {});
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
