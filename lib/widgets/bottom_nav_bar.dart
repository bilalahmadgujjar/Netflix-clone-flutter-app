import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/screens/homepage_movie/home.dart';
import 'package:corona/screens/hot_news/hot_news_page.dart';
import 'package:corona/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final brightness =
        ThemeData.estimateBrightnessForColor(themeController.backgroundColor);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: themeController.backgroundColor,
      systemNavigationBarDividerColor:
          Colors.transparent, // Hide the divider line
      statusBarColor: themeController.backgroundColor,
      statusBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeController.backgroundColor,
        bottomNavigationBar: Container(
          padding: EdgeInsets.zero,
          color: themeController.backgroundColor,
          height: screenHeight(context) * 7.5,
          child: TabBar(
            padding: EdgeInsets.zero,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: screenHeight(context) * 3,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(
                  Icons.photo_library_outlined,
                  size: screenHeight(context) * 3,
                ),
                text: 'New & Hot',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  size: screenHeight(context) * 3,
                ),
                text: 'Profile',
              ),
            ],
            dividerHeight: 0.0,
            indicatorColor: Colors.transparent,
            labelColor: themeController.primaryColor,
            unselectedLabelColor: themeController.primaryColor,
            labelStyle: TextStyle(
              fontSize: screenHeight(context) * 1.7,
              fontFamily: 'PTSans',
               fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: screenHeight(context) * 1.5,
              fontFamily: 'PTSans',
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            HotNewScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
