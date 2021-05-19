import 'package:dio/dio.dart';
import 'package:flutter_app/environment_config.dart';
import 'package:flutter_app/home/movie.dart';
import 'package:flutter_app/home/movies_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieServiceProvider= Provider<MovieService>((ref){
  final config = ref.read(environmentConfigProvider);

  return MovieService(config, Dio());
});

class MovieService {
  MovieService(this._environmentConfig, this._dio);

  final EnvironmentConfig _environmentConfig;
  final Dio _dio;

  Future<List<Movie>> getMovies() async{
    try {
      print("_environmentConfig.movieApiKey");
      print(_environmentConfig.movieApiKey);
      String url = "https://api.themoviedb.org/3/movie/popular?api_key=${_environmentConfig.movieApiKey}&language=en-US&page=1";
      print(url);
      final response = await _dio.get(url);

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> movie = results.map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      return movie;
    } on DioError catch (dioError){
      throw MoviesException.fromDioError(dioError);
    }
  }
}