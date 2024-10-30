// TODO Implement this library.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_event.dart';
import 'movie_state.dart';
import '../repository/movie_repository.dart';

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  PopularMovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final moviess = await movieRepository
            //.fetchMovies('movie/popular?api_key=${ApiConfig.apiKey}');
            .fetchMovies(
                'https://api.themoviedb.org/3/movie/popular?api_key=f9f4783f569fcd1104aaf0a401c35778');
        emit(MovieLoaded(moviess));
      } catch (e) {
        emit(MovieError('Failed to fetch popular movies: $e'));
      }
    });
    on<SearchMovies>((event, emit) async {
      final movies = await movieRepository
          //.fetchMovies('movie/popular?api_key=${ApiConfig.apiKey}');
          .fetchMovies(
              'https://api.themoviedb.org/3/movie/top_rated?api_key=f9f4783f569fcd1104aaf0a401c35778');
      emit(MovieLoaded(movies));

      if (movies.isEmpty) {
        emit(MovieError('No movies available. Please fetch movies first.'));
        return;
      }

      final filteredMovies = movies.where((movie) {
        return movie.title.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      if (filteredMovies.isNotEmpty) {
        emit(MovieLoaded(filteredMovies));
      } else {
        emit(MovieLoaded([]));
      }
    });
  }
}
