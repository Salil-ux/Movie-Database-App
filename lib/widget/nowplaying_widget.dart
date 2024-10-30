// // import 'package:final2/selectedmovie_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'movie_bloc.dart';
// // import 'movie_event.dart';
// // import 'movie_state.dart';
// //
// // class MoviePosterScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<MovieBloc, MovieState>(
// //       builder: (context, state) {
// //         if (state is MovieLoading) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (state is MovieError) {
// //           return Center(child: Text(state.message));
// //         } else if (state is MovieLoaded) {
// //           return SizedBox(
// //             height: MediaQuery.of(context).size.height * 0.5,
// //             child: ListView.builder(
// //               //shrinkWrap: true,
// //               scrollDirection: Axis.horizontal,
// //               itemCount: state.movies.length,
// //               itemBuilder: (context, index) {
// //                 final movie = state.movies[index];
// //                 return Padding(
// //                   padding: const EdgeInsets.all(20.0),
// //                   child: Column(
// //                     children: [
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) {
// //                                 return BlocProvider.value(
// //                                   value: BlocProvider.of<MovieBloc>(context),
// //                                   child: PopularScreen(),
// //                                 );
// //                               },
// //                             ),
// //                           );
// //                         },
// //                         child: Image.network(
// //                           'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
// //                           height: MediaQuery.of(context).size.height * 0.4,
// //                           width: 400,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Text(movie.title,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                           )),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         }
// //         return Center(child: Text('No movies found.'));
// //       },
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../constants/constant_color.dart';
// import '../moviebloc/movie_event.dart';
// import '../screens/selectedmovie_screen.dart';
// import '../moviebloc/movie_bloc.dart';
// import '../moviebloc/movie_state.dart';
// import 'dart:async';
//
// class MoviePosterScreen extends StatefulWidget {
//   const MoviePosterScreen({super.key});
//
//   @override
//   State<MoviePosterScreen> createState() => _MoviePosterScreenState();
// }
//
// class _MoviePosterScreenState extends State<MoviePosterScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startAutoSlide();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _startAutoSlide() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       final state = context.read<MovieBloc>().state;
//       if (state is MovieLoaded) {
//         setState(() {
//           _currentPage = (_currentPage + 1) % state.movies.length;
//         });
//         _pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }
//
//   void _refresh() {
//     context.read<MovieBloc>().add(FetchMovies());
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MovieBloc, MovieState>(
//       builder: (context, state) {
//         if (state is MovieLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is MovieError) {
//           return Center(
//               child: SizedBox(
//             height: 50,
//             width: 150,
//             child: TextButton(
//               onPressed: _refresh,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Appcolor.red,
//                 foregroundColor: Appcolor.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//               child: const Text("Reload"),
//             ),
//           ));
//         } else if (state is MovieLoaded) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: state.movies.length,
//               itemBuilder: (context, index) {
//                 final movie = state.movies[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PopularScreen(
//                                   selectedMovie: movie,
//                                   hero:
//                                       'now_playing-${movie.id}'), // Pass the selected movie
//                             ),
//                           );
//                         },
//                         child: Hero(
//                           tag: 'now_playing-${movie.id}',
//                           child: Image.network(
//                             'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
//                             height: MediaQuery.of(context).size.height * 0.4,
//                             width: 400,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         movie.title,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return const Center(child: Text('No movies found.'));
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constant_color.dart';
import '../moviebloc/movie_event.dart';
import '../screens/selectedmovie_screen.dart';
import '../moviebloc/movie_bloc.dart';
import '../moviebloc/movie_state.dart';
import 'dart:async';

class MoviePosterScreen extends StatefulWidget {
  const MoviePosterScreen({super.key});

  @override
  State<MoviePosterScreen> createState() => _MoviePosterScreenState();
}

class _MoviePosterScreenState extends State<MoviePosterScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final state = context.read<MovieBloc>().state;
      if (state is MovieLoaded && state.movies.isNotEmpty) {
        setState(() {
          _currentPage = (_currentPage + 1) % state.movies.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _refresh() {
    context.read<MovieBloc>().add(FetchMovies());
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: index == _currentPage ? 8.0 : 6.0,
      height: index == _currentPage ? 8.0 : 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == _currentPage ? Appcolor.red : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieError) {
          return Center(
            child: SizedBox(
              height: 50,
              width: 150,
              child: TextButton(
                onPressed: _refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.red,
                  foregroundColor: Appcolor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text("Reload"),
              ),
            ),
          );
        } else if (state is MovieLoaded && state.movies.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PopularScreen(
                                selectedMovie: movie,
                                hero: 'now_playing-${movie.id}',
                                initialIndex: state.movies.indexOf(movie),
                                movies: state.movies,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'now_playing-${movie.id}',
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: 400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              //const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(state.movies.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = index;
                      });
                      _pageController.animateToPage(
                        _currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: _buildDotIndicator(index),
                  );
                }),
              ),
            ],
          );
        }
        return const Center(child: Text('No movies found.'));
      },
    );
  }
}
