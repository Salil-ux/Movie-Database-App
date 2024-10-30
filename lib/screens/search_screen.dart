import 'package:final2/screens/selectedmovie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constant_color.dart';
import '../model/movie.dart';
import '../moviebloc/popular_movie_bloc.dart';
import '../moviebloc/movie_event.dart';
import '../moviebloc/movie_state.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  late TextEditingController _controller;
  List<Movie> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _onSearchChanged() {
    final query = _controller.text;
    if (query.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      return;
    }

    context.read<PopularMovieBloc>().add(SearchMovies(query));
  }

  @override
  Widget build(BuildContext context) {
    void refresh() {
      context.read<PopularMovieBloc>().add(FetchMovies());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) => _onSearchChanged(),
              decoration: InputDecoration(
                labelText: 'Search ',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolor.nred),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolor.nred),
                ),
                labelStyle: TextStyle(color: Appcolor.nred),
                //border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _suggestions.clear();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<PopularMovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    _suggestions = state.movies.where((movie) {
                      return movie.title
                          .toLowerCase()
                          .contains(_controller.text.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        if (_suggestions.isEmpty) {
                          return const ListTile(
                              title: Text('No suggestions found.'));
                        }

                        final movie = _suggestions[index];
                        return ListTile(
                          title: Text(movie.title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PopularScreen(
                                  selectedMovie: movie,
                                  hero: 'trnding-${movie.id}',
                                  initialIndex: state.movies.indexOf(movie),
                                  movies: state.movies,
                                ),
                              ),
                            );
                          },
                          leading: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  } else if (state is MovieError) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: refresh,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.mred,
                        ),
                        child: const Text("Reload"),
                      ),
                    );
                  }
                  return const Center(child: Text('No movies found.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
