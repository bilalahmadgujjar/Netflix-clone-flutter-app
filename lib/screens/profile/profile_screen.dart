import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/widgets/custom_profile_tile.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
        backgroundColor: themeController.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeController.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Profile',
                fontSize: screenHeight(context) * 2.5,
                color: themeController.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              Icon(
                Icons.more_vert,
                color: themeController.primaryColor,
                size: screenHeight(context) * 2.5,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 4,
                  vertical: screenHeight(context) * 2)
              .copyWith(bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: screenHeight(context) * 8,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1725753600&semt=ais_hybrid'),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                CustomText(
                  text: 'Bilal Ahmad',
                  fontSize: screenHeight(context) * 2,
                  color: themeController.textColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight(context) * 1,
                ),
                CustomText(
                  text: 'abcd@gmail.com',
                  fontSize: screenHeight(context) * 2,
                  color: themeController.textColor,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                Divider(
                  color: themeController.disabledColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: screenHeight(context) * 1,
                ),
                CustomProfileTile(
                  text: 'Profile',
                  iconData: Icons.person,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                InkWell(
                    onTap: () {
                      themeController.toggleTheme();
                    },
                    child: CustomProfileTile(
                      text: 'Theme',
                      iconData: themeController.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                    )),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                CustomProfileTile(
                  text: 'Privacy & Policy',
                  iconData: Icons.privacy_tip,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                CustomProfileTile(
                    text: 'Terms & Conditions', iconData: Icons.request_page),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                CustomProfileTile(text: 'Logout', iconData: Icons.logout),
              ],
            ),
          ),
        ));
  }
}

// Center(
// child: Switch(
// value: themeController.isDarkMode,
// onChanged: (value) {
// themeController.toggleTheme();
// },
// ),
// ),
