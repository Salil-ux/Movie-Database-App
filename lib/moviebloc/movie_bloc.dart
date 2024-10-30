// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'api_config.dart';
// import 'movie_event.dart';
// import 'movie_state.dart';
// import 'movie_repository.dart';
//
// class MovieBloc extends Bloc<MovieEvent, MovieState> {
//   final MovieRepository repository;
//
//   MovieBloc(this.repository) : super(MovieInitial());
//
//   @override
//   Stream<MovieState> mapEventToState(MovieEvent event) async* {
//     if (event is FetchMovies) {
//       yield MovieLoading();
//       try {
//         final movies = await repository.fetchMovies(
//             'trending/movie/week?api_key=f9f4783f569fcd1104aaf0a401c35778'); // Replace with your API key
//         yield MovieLoaded(movies);
//       } catch (e) {
//         yield MovieError(e.toString());
//       }
//     }
//   }
// }
// TODO Implement this library.

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
        // try {
        //   final image = await movieRepository
        //       .fetchMovies('https://image.tmdb.org/t/p/w500');
        //   emit(MovieLoaded(image));
        // } catch (e) {
        //   emit(MovieError('Failed to fetch movies: $e'));
        // }
      } catch (e) {
        emit(MovieError('Failed to fetch movies: $e'));
      }
    });
  }
}
