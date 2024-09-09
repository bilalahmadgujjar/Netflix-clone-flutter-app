import 'package:dio/dio.dart';

class ApiServices {
  String serverUrl = "https://api.themoviedb.org/3";
  String accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOGNjNmE1YmJmMDA3NjAzMTIzMmI0YmU5YTMwMjY4YyIsInN1YiI6IjY0ZmNhMGVlZGI0ZWQ2MTAzMmE1OWI4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HBi7nKLDLmxjxUkZVpvg4X7gTtypFknwlm5s43GhDkM";
  // String apiKey = "08cc6a5bbf0076031232b4be9a30268c";

  Dio dio = Dio();
  getApiMethodWT(String url) async {
    try {
     print('URL $serverUrl$url');
      final response = await dio.get('$serverUrl$url',
          options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json',
              },
              validateStatus: (status) {
                print(status);
                return status! < 500;
              }));

      return response;
    } catch (e) {
      throw Exception('Failed to Getdata: $e');
    }
  }

  // getApiMethod(String url) async {
  //   try {
  //     final response = await dio.get('$serverUrl$url');
  //     if (response.statusCode == 500) {
  //       print('Error');
  //       return null;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load product data: $e');
  //   }
  // }
  //
  // getApiMethodQuery(String url, {String? query}) async {
  //   try {
  //     print('GET API');
  //     print(query);
  //     print('$serverUrl$url$query');
  //     final response = await dio.get('$serverUrl$url$query');
  //
  //     if (response.statusCode == 500) {
  //       print('Error');
  //       return null;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load product data: $e');
  //   }
  // }
}
