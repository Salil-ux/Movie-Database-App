//part of 'movie_bloc.dart';
import '../model/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}

class MovieSelection extends MovieState {
  final int index;
  final List<Movie> selmovie;

  MovieSelection(this.selmovie, this.index);
}
// TODO Implement this library.
