import 'package:corona/models/detail_movie_model.dart';
import 'package:corona/models/search_movie_model.dart';
import 'package:corona/services/api_services.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  MovieProvider() {}
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///TODO this list store search
  final List<SearchMovieModel> _searchList = [];
  List<SearchMovieModel> get searchList => _searchList;

  ///TODO this list store Movie Detail
  MovieDetailModel? _movieDetail;
  MovieDetailModel? get movieDetail => _movieDetail;

  /// =========== SEARCH ==============
  getSearch(String query) async {
    try {
      var response =
          await ApiServices().getApiMethodWT('/search/movie?query=$query');

      print(response.data);
      if (response != null && response.data != null) {
        var jsonData = response.data['results'];
        if (jsonData != null) {
          _searchList.clear();
          for (var item in jsonData) {
            SearchMovieModel search = SearchMovieModel.fromJson(item);
            _searchList.add(search);
          }
          _isLoading = true;
          notifyListeners();
        }
      } else {
        _isLoading = false;
      }
    } catch (e) {
      _isLoading = false;
      print('Error fetching : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// =========== DETAIL OF THE MOVIE ==============
  getMovieDetails(int id) async {
    try {
      _movieDetail = MovieDetailModel();
      var response =
          await ApiServices().getApiMethodWT('/movie/$id?language=en-US');
      print(response.data);
      if (response != null && response.data != null) {
        var jsonData = response.data;
        _movieDetail = MovieDetailModel.fromJson(jsonData);
        _isLoading = true;
        notifyListeners();
      } else {
        _isLoading = false;
      }
    } catch (e) {
      _isLoading = false;
      print('Error fetching : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// =========== Clear ==============
  void clear() {
    _searchList.clear();
    _movieDetail = MovieDetailModel();
    notifyListeners();
  }
}
