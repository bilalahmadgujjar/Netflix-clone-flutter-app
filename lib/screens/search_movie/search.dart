import 'dart:async';

import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/providers/movie_provider.dart';
import 'package:corona/screens/homepage_movie/home.dart';
import 'package:corona/screens/search_movie/movie_detail.dart';
import 'package:corona/services/api_services.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:corona/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final movieController = Provider.of<MovieProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 4,
                  vertical: screenHeight(context) * 2)
              .copyWith(bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * 5,
                  child: CustomTextFormField(
                    controller: searchController,
                    hintText: 'Search movie name...',
                    prefixIcon: Icons.search,
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                                movieController.getSearch('');
                              });
                            },
                            icon: Icon(
                              Icons.clear,
                              size: screenHeight(context) * 2.5,
                              color: themeController.greyColor,
                            ),
                          )
                        : null,
                    onChanged: (value) {
                      setState(() {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          movieController.getSearch(value);
                        });

                        //movieController.getSearch(searchController.text);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.5,
                ),
                SizedBox(
                  height: screenHeight(context) * 90,
                  child: Builder(builder: (context) {
                    if (movieController.searchList.isEmpty &&
                        searchController.text.isNotEmpty) {
                      return Center(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: themeController.primaryColor,
                          strokeWidth: 2,
                        )),
                      );

                      // findJobProvider.findJobList.isEmpty && findJobProvider.isLoading
                    } else if (searchController.text.isEmpty) {
                      return topRatedMovies.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                              color: themeController.primaryColor,
                              strokeWidth: 2,
                            ))
                          : ListView.builder(
                              itemCount: topRatedMovies.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.all(screenWidth(context) * 2),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MovieDetail(
                                                  id: topRatedMovies[index]
                                                      ['id'])));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            '$imageUrl${topRatedMovies[index]['poster_path']}',
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return SizedBox.shrink();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth(context) * 3,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: topRatedMovies[index]
                                                        ['original_title'] ??
                                                    '',
                                                color:
                                                    themeController.textColor,
                                                fontSize:
                                                    screenHeight(context) * 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              SizedBox(
                                                height:
                                                    screenHeight(context) * 1,
                                              ),
                                              CustomText(
                                                text: topRatedMovies[index]
                                                        ['overview'] ??
                                                    '',
                                                textAlign: TextAlign.justify,
                                                color:
                                                    themeController.textColor,
                                                fontSize:
                                                    screenHeight(context) * 1,
                                              ),
                                              SizedBox(
                                                height:
                                                    screenHeight(context) * 1,
                                              ),
                                              CustomText(
                                                text: topRatedMovies[index]
                                                        ['release_date'] ??
                                                    '',
                                                textAlign: TextAlign.justify,
                                                color:
                                                    themeController.textColor,
                                                fontSize:
                                                    screenHeight(context) * 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: screenHeight(context) * 0.1,
                                  crossAxisSpacing: screenHeight(context) * 0.5,
                                  // childAspectRatio: screenWidth(context)*0.1
                                  //crossAxisSpacing: 5,
                                  // childAspectRatio: 1.2 / 2
                                  childAspectRatio: 1 / 1.9),
                          itemCount: movieController.searchList.length,
                          itemBuilder: (context, index) {
                            final search = movieController.searchList[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetail(id: search.id)));
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    '$imageUrl${search.posterPath}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox();
                                    },
                                  ),
                                  CustomText(
                                    text: search.title,
                                    fontSize: screenHeight(context) * 1.5,
                                    color: themeController.textColor,
                                    max: 2,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
