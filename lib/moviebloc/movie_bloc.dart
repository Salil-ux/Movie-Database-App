import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';
import 'movie_state.dart';
import '../repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await movieRepository.fetchMovies(
            'https://api.themoviedb.org/3/movie/top_rated?api_key=f9f4783f569fcd1104aaf0a401c35778');
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError('Failed to fetch movies: $e'));
      }
    });
  }
}
