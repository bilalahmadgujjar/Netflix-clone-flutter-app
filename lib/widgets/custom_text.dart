import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow? overFlow;
  final int? max;

  const CustomText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    required this.color,
    this.overFlow,
    this.max,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: overFlow,
      maxLines: max,
      text,
      textAlign: textAlign,
      //textAlign: TextAlign.center,
      style: TextStyle(
        // decoration: decoration,
        //fontFamily: 'Sans',
        fontFamily: 'PTSans', // Use your custom font family here
        fontSize: fontSize,
        //fontWeight: FontWeight.bold,

        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
