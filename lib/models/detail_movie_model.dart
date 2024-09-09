class MovieDetailModel {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  List<String> originCountry;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<dynamic> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailModel({
    this.adult = false,
    this.backdropPath = '',
    this.belongsToCollection,
    this.budget = 0,
    this.genres = const [],
    this.homepage = '',
    this.id = 0,
    this.imdbId = '',
    this.originCountry = const [],
    this.originalLanguage = '',
    this.originalTitle = '',
    this.overview = '',
    this.popularity = 0.0,
    this.posterPath = '',
    this.productionCompanies = const [],
    this.productionCountries = const [],
    this.releaseDate = '',
    this.revenue = 0,
    this.runtime = 0,
    this.spokenLanguages = const [],
    this.status = '',
    this.tagline = '',
    this.title = '',
    this.video = false,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((item) => Genre.fromJson(item))
              .toList() ??
          [],
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? '',
      originCountry: List<String>.from(json['origin_country'] ?? []),
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies: json['production_companies'] ?? [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
              ?.map((item) => ProductionCountry.fromJson(item))
              .toList() ??
          [],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((item) => SpokenLanguage.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({
    this.id = 0,
    this.name = '',
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    this.iso31661 = '',
    this.name = '',
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    this.englishName = '',
    this.iso6391 = '',
    this.name = '',
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] ?? '',
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
