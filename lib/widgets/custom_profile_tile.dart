import 'package:corona/common/utils.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/theme/controller.dart';

class CustomProfileTile extends StatefulWidget {
  final String text;
  final IconData iconData;
  const CustomProfileTile({super.key, required this.text, required this.iconData});

  @override
  State<CustomProfileTile> createState() => _CustomProfileTileState();
}

class _CustomProfileTileState extends State<CustomProfileTile> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Row(
      children: [
        Container(
          height: screenHeight(context) * 5,
          width: screenWidth(context) * 10,
          decoration: BoxDecoration(
            color: themeController.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            widget.iconData,
            color: themeController.backgroundColor,
            size: screenHeight(context) * 3,
          ),
        ),
        SizedBox(
          width: screenWidth(context) * 3,
        ),
        CustomText(
          text: widget.text,
          fontSize: screenHeight(context) * 2,
          color: themeController.textColor,
          fontWeight: FontWeight.bold,
        ),
        Spacer(),
        Icon(
          Icons.navigate_next,
          color: themeController.primaryColor,
          size: screenHeight(context) * 3,
        ),
      ],
    );
  }
}
