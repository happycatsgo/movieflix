import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String now = "now-playing";

  static Future<List<MovieModel>> getMovies(String category) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/$category");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      for (var movie in jsonResponse["results"]) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    } else {
      throw Error();
    }
  }

  static Future<MovieDetailModel> getDetail(int id) async {
    final url =
        Uri.parse("https://movies-api.nomadcoders.workers.dev/movie?id=$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Error();
    }
  }
}
