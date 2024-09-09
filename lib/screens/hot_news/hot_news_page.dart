import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/screens/homepage_movie/home.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_hot_new_screen.dart';

class HotNewScreen extends StatefulWidget {
  const HotNewScreen({Key? key}) : super(key: key);

  @override
  State<HotNewScreen> createState() => _HotNewScreenState();
}

class _HotNewScreenState extends State<HotNewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              text: 'News & Hot',
              fontSize: screenHeight(context) * 2.5,
              color: themeController.textColor,
              fontWeight: FontWeight.bold,
            ),
            Icon(
              Icons.cast,
              color: themeController.primaryColor,
              size: screenHeight(context) * 2.5,
            ),
          ],
        ),
        centerTitle: true, // Align the title in the center

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: screenHeight(context) * 5,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: Colors.greenAccent
              ),
              child: TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: themeController.textColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                labelColor: themeController.backgroundColor,
                unselectedLabelColor: themeController.primaryColor,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                controller: _tabController, // Provide the TabController
                tabs: [
                  Tab(
                    text: '🍿 Coming Soon', // Title for the first tab
                  ),
                  Tab(
                    text: "🔥 Everyone's watching", // Title for the second tab
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight(context) * 4),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController, // Provide the same TabController
                  children: [
                    ///TODO Coming Soon Screen
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 1),
                      child: upcomingMovies.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: themeController.primaryColor,
                                strokeWidth: 2,
                              ),
                            )
                          : ListView.builder(
                              itemCount: upcomingMovies.length,
                              itemBuilder: (context, index) {
                                return CustomHotNew(
                                  date: upcomingMovies[index]['release_date'],
                                  imageUrl: upcomingMovies[index]
                                      ['poster_path'],
                                  detail: upcomingMovies[index]['overview'],
                                  id: upcomingMovies[index]['id'],
                                );
                              },
                            ),
                    ),

                    ///TODO Everyone Screen
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 1),
                      child: nowPlayingMovies.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                                color: themeController.primaryColor,
                                strokeWidth: 2,
                              ),
                            )
                          : ListView.builder(
                              itemCount: nowPlayingMovies.length,
                              itemBuilder: (context, index) {
                                return CustomHotNew(
                                  date: nowPlayingMovies[index]['release_date'],
                                  imageUrl: nowPlayingMovies[index]
                                      ['poster_path'],
                                  detail: nowPlayingMovies[index]['overview'],
                                  id: nowPlayingMovies[index]['id'],
                                );
                              },
                            ),
                    ),
                    // Content for the second tab
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
