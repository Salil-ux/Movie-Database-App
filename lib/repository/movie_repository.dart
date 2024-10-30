// TODO Implement this library.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api_config.dart';
import '../model/movie.dart';

class MovieRepository {
  Future<List<Movie>> fetchMovies(String endpoint) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/movie/popular?api_key=${ApiConfig.apiKey}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
