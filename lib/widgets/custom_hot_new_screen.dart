import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/screens/search_movie/movie_detail.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CustomHotNew extends StatefulWidget {
  final String date;
  final String imageUrl;
  final String detail;
  final int id;
  const CustomHotNew(
      {super.key,
      required this.date,
      required this.imageUrl,
      required this.detail,
      required this.id});

  @override
  State<CustomHotNew> createState() => _CustomHotNewState();
}

class _CustomHotNewState extends State<CustomHotNew> {
  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final String formattedDate = DateFormat('MMM d').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth(context) * 1),
              child: CustomText(
                  //  text: '${widget.date}',
                  text: formatDate(widget.date),
                  fontSize: screenHeight(context) * 3,
                  color: themeController.textColor),
            )),
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: ()
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetail(id: widget.id)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network('$imageUrl${widget.imageUrl}'),
                ),
                SizedBox(
                  height: screenHeight(context) * 1,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight(context) * 2.5,
                      backgroundColor: themeController.primaryColor,
                      backgroundImage: AssetImage('assets/netflix.png'),
                    ),
                    Spacer(),
                    Icon(
                      Icons.info_outline,
                      color: themeController.primaryColor,
                      size: screenHeight(context) * 2.5,
                    ),
                    SizedBox(
                      width: screenWidth(context) * 3,
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: themeController.primaryColor,
                      size: screenHeight(context) * 2.5,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 1,
                ),
                CustomText(
                  text: 'Overview',
                  fontSize: screenHeight(context) * 2,
                  color: themeController.primaryColor,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.5,
                ),
                CustomText(
                  text: widget.detail,
                  fontSize: screenHeight(context) * 1.5,
                  color: themeController.disabledColor2,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
