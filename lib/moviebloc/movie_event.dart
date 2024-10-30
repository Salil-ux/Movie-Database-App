abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}
// TODO Implement this library.

class SelectedMovie extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies(this.query);
}
