import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    this.labelTextfontSize,
    this.keyboadType = TextInputType.name,
    this.labelText = "Enter something here",
    this.hideText = false,
    this.hintStyle,
    this.trailing,
    this.valid,
    this.textInputAction,
    this.focusNode,
    this.onfieldSubmit,
  });
  final TextEditingController controller;
  final double? labelTextfontSize;
  TextInputType keyboadType;
  FocusNode? focusNode;
  TextInputAction? textInputAction;

  void Function(String)? onfieldSubmit;

  String? Function(String?)? valid;
  String labelText;
  bool hideText;
  TextStyle? hintStyle;
  Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: valid,
      focusNode: focusNode,
      keyboardType: keyboadType,
      textInputAction: textInputAction,
      obscureText: hideText,
      onFieldSubmitted: onfieldSubmit,
      style: TextStyle(
        fontSize: labelTextfontSize ?? 12,
        color: Colors.grey.shade700,
      ),
      decoration: InputDecoration(
        suffixIcon: trailing ?? null,
        labelText: labelText,
        labelStyle: GoogleFonts.cairo(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: labelTextfontSize ?? 14,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
      ),
    );
  }
}
