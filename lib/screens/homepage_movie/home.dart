import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/screens/search_movie/movie_detail.dart';
import 'package:corona/screens/search_movie/search.dart';
import 'package:corona/services/api_services.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

List upcomingMovies = [];
List nowPlayingMovies = [];
List sliderMovies = [];
List popularMovies = [];
List topRatedMovies = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int popularPage = 1;
  int nowPlayingPage = 1;
  int topRatedPage = 1;
  int upcomingPage = 1;
  int sliderPage = 1;

  final ScrollController _popularScrollController = ScrollController();
  final ScrollController _nowPlayingScrollController = ScrollController();
  final ScrollController _topRatedScrollController = ScrollController();
  final ScrollController _upcomingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //if(mounted) return;
    getAllData();

    _popularScrollController.addListener(() {
      if (_popularScrollController.position.pixels ==
          _popularScrollController.position.maxScrollExtent) {
        popularPage++;
        getPopularMovie();
      }
    });

    _nowPlayingScrollController.addListener(() {
      if (_nowPlayingScrollController.position.pixels ==
          _nowPlayingScrollController.position.maxScrollExtent) {
        nowPlayingPage++;
        getNowPlayingMovie();
      }
    });

    _topRatedScrollController.addListener(() {
      if (_topRatedScrollController.position.pixels ==
          _topRatedScrollController.position.maxScrollExtent) {
        topRatedPage++;
        getTopRatedMovie();
      }
    });

    _upcomingScrollController.addListener(() {
      if (_upcomingScrollController.position.pixels ==
          _upcomingScrollController.position.maxScrollExtent) {
        upcomingPage++;
        getUpComingMovie();
      }
    });
  }

  getAllData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (popularMovies.isEmpty) await getPopularMovie();
      if (nowPlayingMovies.isEmpty) await getNowPlayingMovie();
      if (topRatedMovies.isEmpty) await getTopRatedMovie();
      if (upcomingMovies.isEmpty) await getUpComingMovie();
      if (sliderMovies.isEmpty) await getSliderMovie();
    } catch (e) {
      print('Error in Home Screen: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _popularScrollController.dispose();
    _nowPlayingScrollController.dispose();
    _topRatedScrollController.dispose();
    _upcomingScrollController.dispose();
    super.dispose();
  }
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    print(sliderMovies.length);

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeController.backgroundColor,
        appBar: AppBar(
          toolbarHeight: screenHeight(context) * 6,
          titleSpacing: 0,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: themeController.backgroundColor,
          title: Row(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                fit: BoxFit.cover,
                'assets/logo.png',
                height: screenHeight(context) * 5,
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(
                  Icons.search,
                  color: themeController.primaryColor,
                  size: screenHeight(context) * 3,
                ),
              ),


            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * 4,
                  vertical: screenHeight(context) * 2)
              .copyWith(bottom: 0, top: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Slider Movies
                //
                // sliderMovies.isEmpty
                //     ? Center(
                //         child: CircularProgressIndicator(
                //         color: themeController.primaryColor,
                //         strokeWidth: 2,
                //       ))
                //     : CarouselSlider.builder(
                //         itemCount: sliderMovies.length,
                //         options: CarouselOptions(
                //           height: screenHeight(context) * 25,
                //           autoPlay: true,
                //           enlargeCenterPage: false,
                //           aspectRatio: 16 / 9,
                //           viewportFraction:
                //               0.9, // Adjusted to display more of the next/previous posters
                //         ),
                //         itemBuilder: (context, index, realIdx) {
                //           return SizedBox(
                //             width:
                //                 screenWidth(context) * 120, // Increased width
                //
                //             child: Stack(
                //               children: [
                //                 Opacity(
                //                   opacity: 0.7,
                //                   child: InkWell(
                //                     onTap: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (context) => MovieDetail(
                //                                   id: sliderMovies[index]
                //                                       ['id'])));
                //                     },
                //                     child: Padding(
                //                         padding: EdgeInsets.symmetric(
                //                             horizontal:
                //                                 screenWidth(context) * 1),
                //                         child: Image(
                //                           image: NetworkImage(
                //                               '$imageUrl${sliderMovies[index]['backdrop_path']}'),
                //                           //   width: screenWidth(context) * 80, // Increased width to match the SizedBox
                //                           height: screenHeight(context) * 50,
                //                           fit: BoxFit.cover,
                //                           errorBuilder:
                //                               (context, error, stackTrace) {
                //                             // You can return an empty Container, a placeholder image, or any other widget
                //                             return SizedBox();
                //                           },
                //                         )),
                //                   ),
                //                 ),
                //                 Padding(
                //                     padding: EdgeInsets.symmetric(
                //                         horizontal: screenWidth(context) * 2),
                //                     child: CustomText(
                //                       text: sliderMovies[index]
                //                               ['original_name'] ??
                //                           '',fontWeight: FontWeight.bold,
                //                       fontSize: screenHeight(context) * 2,
                //                       color: themeController.primaryColor,
                //                     ))
                //               ],
                //             ),
                //           );
                //         },
                //       ),
                //
                // SizedBox(
                //   height: screenHeight(context) * 2,
                // ),
                //

                sliderMovies.isEmpty
                    ? Center(
                    child: CircularProgressIndicator(
                      color: themeController.primaryColor,
                      strokeWidth: 2,
                    ))
                    : Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: sliderMovies.length,
                      options: CarouselOptions(
                        height: screenHeight(context) * 25,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIdx) {
                        return SizedBox(
                          width: screenWidth(context) * 120,
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                          id: sliderMovies[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth(context) * 1,
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                        '$imageUrl${sliderMovies[index]['backdrop_path']}',
                                      ),
                                      height: screenHeight(context) * 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return SizedBox();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context) * 2,
                                ),
                                child: CustomText(
                                  text: sliderMovies[index]['original_name'] ?? '',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight(context) * 2,
                                  color: themeController.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sliderMovies.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _carouselController.animateToPage(entry.key),
                          child: Container(
                            width: screenWidth(context)*1.5,
                            height: screenHeight(context)*1,
                            margin: EdgeInsets.symmetric(
                              vertical:screenHeight(context)*0.5,
                              horizontal: screenWidth(context)*0.5,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? themeController.primaryColor
                                  : themeController.primaryColor)
                                  .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                SizedBox(
                  height: screenHeight(context) * 0.5,
                ),
                /// Now Playing Movies
                CustomText(
                  text: 'Now Playing',
                  fontSize: screenHeight(context) * 2.5,
                  color: themeController.textColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                SizedBox(
                  height: screenHeight(context) * 30,
                  child: nowPlayingMovies.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: themeController.primaryColor,
                          strokeWidth: 2,
                        ))
                      : ListView.builder(
                          controller: _nowPlayingScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: nowPlayingMovies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                            id: nowPlayingMovies[index]
                                                ['id'])));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth(context) * 4),
                                child: Image.network(
                                  '$imageUrl${nowPlayingMovies[index]['poster_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),

                /// Popular Movies
                CustomText(
                  text: 'Popular Movies',
                  fontSize: screenHeight(context) * 2.5,
                  color: themeController.textColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                SizedBox(
                  height: screenHeight(context) * 30,
                  child: popularMovies.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: themeController.primaryColor,
                          strokeWidth: 2,
                        ))
                      : ListView.builder(
                          controller: _popularScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: popularMovies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                            id: popularMovies[index]['id'])));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth(context) * 4),
                                child: Image.network(
                                  '$imageUrl${popularMovies[index]['poster_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),

                /// Top Rated Movies
                CustomText(
                  text: 'Top Rated Movies',
                  fontSize: screenHeight(context) * 2.5,
                  color: themeController.textColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                SizedBox(
                  height: screenHeight(context) * 30,
                  child: topRatedMovies.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: themeController.primaryColor,
                          strokeWidth: 2,
                        ))
                      : ListView.builder(
                          controller: _topRatedScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: topRatedMovies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                            id: topRatedMovies[index]['id'])));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth(context) * 4),
                                child: Image.network(
                                  '$imageUrl${topRatedMovies[index]['poster_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),

                /// Upcoming Movies
                CustomText(
                  text: 'Upcoming Movies',
                  fontSize: screenHeight(context) * 2.5,
                  color: themeController.textColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight(context) * 2,
                ),
                SizedBox(
                  height: screenHeight(context) * 30,
                  child: upcomingMovies.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                          color: themeController.primaryColor,
                          strokeWidth: 2,
                        ))
                      : ListView.builder(
                          controller: _upcomingScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingMovies.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieDetail(
                                            id: upcomingMovies[index]['id'])));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth(context) * 4),
                                child: Image.network(
                                  '$imageUrl${upcomingMovies[index]['poster_path']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///TODO ALL METHOD THAT USING IN THIS FILE HERE USING
  getPopularMovie() async {
    try {
      setState(() {
        isLoading = true;
      });

      var response = await ApiServices()
          .getApiMethodWT('/movie/popular?language=en-US&page=$popularPage');
      print('Popular : $response');
      if (response.statusCode == 200) {
        setState(() {
          popularMovies.addAll(response.data['results']);
        });
      } else {
        print('Not Load Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getNowPlayingMovie() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await ApiServices().getApiMethodWT(
          '/movie/now_playing?language=en-US&page=$nowPlayingPage');
      print('Now Playing : $response');
      if (response.statusCode == 200) {
        setState(() {
          nowPlayingMovies.addAll(response.data['results']);
        });
      } else {
        print('Not Load Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getTopRatedMovie() async {
    try {
      setState(() {
        isLoading = true;
      });

      var response = await ApiServices()
          .getApiMethodWT('/movie/top_rated?language=en-US&page=$topRatedPage');
      print('Top Rated : $response');
      if (response.statusCode == 200) {
        setState(() {
          topRatedMovies.addAll(response.data['results']);
        });
      } else {
        print('Not Load Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getUpComingMovie() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await ApiServices().getApiMethodWT(
          '/trending/movie/day?language=en-US&page=$upcomingPage');
      print('Up Coming : $response');
      if (response.statusCode == 200) {
        setState(() {
          upcomingMovies.addAll(response.data['results']);
        });
      } else {
        print('Not Load Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getSliderMovie() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response =
          await ApiServices().getApiMethodWT('/tv/top_rated?page=$sliderPage');
      print('Slider : $response');
      if (response.statusCode == 200) {
        setState(() {
          sliderMovies.addAll(response.data['results']);
        });
      } else {
        print('Not Load Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
