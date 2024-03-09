// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class PhoneNumberField extends StatefulWidget {
  final FocusNode? nextNode;
  PhoneNumber? number;
  String? fieldTitle;
  ValueChanged<PhoneNumber>? valueChanged;
  final TextEditingController? phoneNumberController;
  FocusNode? numberFN;
  PhoneNumberField({
    super.key,
    this.fieldTitle,
    this.valueChanged,
    this.nextNode,
    this.number,
    this.numberFN,
    this.phoneNumberController,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        InternationalPhoneNumberInput(
          textStyle: AppTextStyles.poppinsRegular(
            fontSize: 12.sp,
            color: AppColors.black,
            fontWeight:
                widget.numberFN!.hasFocus ? FontWeight.w500 : FontWeight.w300,
          ),
          maxLength: 10,
          focusNode: widget.numberFN,
          inputDecoration: InputDecoration(
            isDense: true,
            suffixIcon: Icon(
              Icons.phone_outlined,
              color: widget.numberFN!.hasFocus
                  ? AppColors.primary
                  : AppColors.grey,
            ),
            hintText: '000 000 000 ',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: AppColors.primary.withOpacity(.1),
            hintStyle: AppTextStyles.poppinsRegular(
              fontSize: 12.sp,
              color: AppColors.black,
              fontWeight:
                  widget.numberFN!.hasFocus ? FontWeight.w500 : FontWeight.w300,
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: AppColors.red,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: AppColors.primary,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.lightGrey,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: AppColors.red,
                )),
          ),
          // locale: Get.locale.toString() == "en_US" ? "en" : "ar",
          onInputChanged: (PhoneNumber phonenumber) {
            widget.number = phonenumber;
            widget.valueChanged!(phonenumber);
          },
          // errorMessage: 'Invalid phone no',
          onInputValidated: (val) {
            // debugPrint(val.toString());
          },
          // selectorConfig: const SelectorConfig(
          //     leadingPadding: 10,
          //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          //     showFlags: false,
          //     setSelectorButtonAsPrefixIcon: true,
          //     trailingSpace: true),

          spaceBetweenSelectorAndTextField: 0,
          selectorTextStyle: const TextStyle(color: AppColors.primary),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          initialValue: widget.number,
          textFieldController: widget.phoneNumberController,
          formatInput: false,
          keyboardAction: TextInputAction.done,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          inputBorder: const UnderlineInputBorder(),
          onSaved: (PhoneNumber number) {
            debugPrint('On Saved: $number');
          },
          onFieldSubmitted: (value) {
            setState(() {});
            FocusScope.of(context).requestFocus(widget.nextNode ?? FocusNode());
          },
        ),
      ],
    );
  }
}
