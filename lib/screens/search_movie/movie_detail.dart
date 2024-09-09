import 'package:corona/common/theme/controller.dart';
import 'package:corona/common/utils.dart';
import 'package:corona/providers/movie_provider.dart';
import 'package:corona/services/api_services.dart';
import 'package:corona/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  const MovieDetail({super.key, required this.id});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool isLoading = true;
  List recommendMovies = [];
  List trailerMovies = [];

  late YoutubePlayerController _controller;

  getRecommendMovie(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      var response = await ApiServices()
          .getApiMethodWT('/movie/$id/recommendations?language=en-US&page=1');
      print('Recommend Movie : $response');
      if (response.statusCode == 200) {
        setState(() {
          recommendMovies = response.data['results'];
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

  getTrailer(int id) async {
    try {
      setState(() {
        isLoading = true;
      });

      var response = await ApiServices().getApiMethodWT('/movie/$id/videos');
      print('Trailer Movie : $response');
      if (response.statusCode == 200) {
        setState(() {
          trailerMovies = response.data['results'];
          if (trailerMovies.isNotEmpty) {
            _controller = YoutubePlayerController(
                initialVideoId: trailerMovies.first['key'],
                flags: YoutubePlayerFlags(autoPlay: true, mute: false));
          }
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

  getAllData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (recommendMovies.isEmpty) await getRecommendMovie(widget.id);
      if (trailerMovies.isEmpty) await getTrailer(widget.id);
    } catch (e) {
      print('Error in Home Screen: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMovieDetails() async {
    final movieController = Provider.of<MovieProvider>(context, listen: false);
    await movieController.getMovieDetails(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '', // Provide a default value
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    _loadMovieDetails();
    getAllData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final movieController = Provider.of<MovieProvider>(context);
    final movieDetail = movieController.movieDetail;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: movieController.isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: themeController.primaryColor,
                strokeWidth: 2,
              ))
            : movieDetail != null
                ? SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: screenHeight(context) * 35,
                              width: double.infinity,
                              child: Image.network(
                                '$imageUrl${movieDetail.backdropPath}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox.shrink();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth(context) * 4,
                                      vertical: screenHeight(context) * 2)
                                  .copyWith(bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: movieDetail.title,
                                    fontSize: screenHeight(context) * 2.5,
                                    color: themeController.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 2,
                                  ),
                                  CustomText(
                                    text: '${movieDetail.tagline} ',
                                    fontSize: screenHeight(context) * 1.8,
                                    color: themeController.disabledColor2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text:
                                        '${movieDetail.status} Date:   ${movieDetail.releaseDate}',
                                    fontSize: screenHeight(context) * 1.8,
                                    color: themeController.disabledColor2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text: movieDetail.adult == true
                                        ? '15+'
                                        : '18+',
                                    fontSize: screenHeight(context) * 1.8,
                                    color: themeController.redColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 4,
                                  ),
                                  CustomText(
                                    text: '${movieDetail.overview} ',
                                    textAlign: TextAlign.justify,
                                    fontSize: screenHeight(context) * 1.8,
                                    color: themeController.disabledColor2,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  ///TODO MOVIE TRAILER
                                  SizedBox(
                                    height: screenHeight(context) * 4,
                                  ),
                                  CustomText(
                                    text: 'Official Trailer',
                                    fontSize: screenHeight(context) * 2.5,
                                    color: themeController.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  trailerMovies.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: themeController.primaryColor,
                                          strokeWidth: 2,
                                        ))
                                      : YoutubePlayer(
                                          controller: _controller,
                                          showVideoProgressIndicator: true,
                                          progressIndicatorColor: themeController.primaryColor,
                                          onReady: () {
                                            print('Player is ready.');
                                          },
                                        ),

                                  ///TODO MORE LIKE THIS MOVIES
                                  SizedBox(
                                    height: screenHeight(context) * 4,
                                  ),
                                  CustomText(
                                    text: 'More like this',
                                    fontSize: screenHeight(context) * 2.5,
                                    color: themeController.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: screenHeight(context) * 2,
                                  ),

                                  SizedBox(
                                    height: screenHeight(context) * 20,
                                    child: recommendMovies.isEmpty
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: themeController.primaryColor,
                                            strokeWidth: 2,
                                          ))
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: recommendMovies.length,
                                            itemBuilder: (context, index) {
                                              ///TODO AGAIN DETAIL BUTTON OF THE SCREEN

                                              return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetail(
                                                          id: recommendMovies[
                                                              index]['id'],
                                                        ),
                                                      ),
                                                    ).then((_) {
                                                      // Update only the required data, if needed
                                                      getRecommendMovie(
                                                          recommendMovies[index]
                                                              ['id']);
                                                    });
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: screenWidth(
                                                                  context) *
                                                              4),
                                                      child: Image.network(
                                                          '$imageUrl${recommendMovies[index]['poster_path']}',
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                        return SizedBox();
                                                      })));
                                            },
                                          ),
                                  ),

                                  SizedBox(
                                    height: screenHeight(context) * 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 5,
                          top: 1,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,
                                  size: screenHeight(context) * 2.5,
                                  color: themeController.textColor)),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CustomText(
                      text: 'Loading...',
                      color: themeController.primaryColor,
                      fontSize: screenHeight(context) * 3,
                    ),
                  ),
      ),
    );
  }
}
