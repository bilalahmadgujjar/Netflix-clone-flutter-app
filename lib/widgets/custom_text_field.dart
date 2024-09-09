import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final bool autoFocus;
  final Widget? suffixIcon;
  final IconData? prefixIcon;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.autoFocus = false,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return TextFormField(
      cursorColor: themeController.greyColor,
      cursorHeight: screenHeight(context) * 3,
      controller: controller,
      autofocus: autoFocus,
      style: TextStyle(
        color: themeController.greyColor, // Customize the text color
        fontSize: screenHeight(context) * 1.8, // Customize the font size
        fontFamily: 'PTSans', // Customize the font family
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeController.greyColor,
          fontSize: screenHeight(context) * 1.8,
          fontFamily: 'PTSans',
        ),

        filled: true,
        fillColor: themeController.searchColor,

        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: screenHeight(context) * 2.5,
                color: themeController.greyColor,
              )
            : null,
        suffixIcon: suffixIcon,
        //enabledBorder: InputBorder.none,
        //focusedBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // More rounded corners
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeController.searchColor, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeController.searchColor, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
