import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:renan_s_application8/core/app_export.dart';

// ignore: must_be_immutable
class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    Key? key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 5,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? theme.textTheme.titleLarge,
        hintStyle: hintStyle ?? theme.textTheme.titleLarge,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 50.h,
          fieldWidth: 50.h,
          shape: PinCodeFieldShape.box,
          inactiveFillColor: appTheme.blueGray10001,
          activeFillColor: appTheme.blueGray10001,
          selectedFillColor: appTheme.blueGray10001,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          selectedColor: Colors.transparent,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
