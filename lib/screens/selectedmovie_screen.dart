import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../constants/constant_color.dart';

import '../model/movie.dart';

class PopularScreen extends StatelessWidget {
  final Movie selectedMovie;
  final String hero;
  final List<Movie> movies;
  final int initialIndex;

  const PopularScreen(
      {super.key,
      required this.selectedMovie,
      required this.initialIndex,
      required this.hero,
      required this.movies});

  @override
  Widget build(BuildContext context) {
    double percent = (selectedMovie.voteAverage / 10);
    int rating = (selectedMovie.voteAverage * 10).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie DB'),
        backgroundColor: Appcolor.red,
      ),
      body: PageView.builder(
          itemCount: movies.length,
          controller: PageController(initialPage: initialIndex),
          itemBuilder: (context, index) {
            final selectedMovie = movies[index];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        selectedMovie.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Hero(
                      tag: hero,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${selectedMovie.posterPath}',
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: 400,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Align(
                        alignment: Alignment.center,
                        child: CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: percent,
                          center: Text('$rating%',
                              style: const TextStyle(fontSize: 17)),
                          progressColor:
                              percent > 0.6 ? Colors.green : Appcolor.red,
                        )),

                    const SizedBox(height: 10),
                    // Text(selectedMovie.title,
                    //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    const Text(
                      'Synopsis :',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '               ${selectedMovie.overview}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Rating: ${selectedMovie.voteAverage}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../model/movie.dart';
//
// class PopularScreen extends StatelessWidget {
//   final List<Movie> movies;
//   final int initialIndex; //
//
//   const PopularScreen(
//       {Key? key, required this.movies, required this.initialIndex})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movie Details'),
//       ),
//       body: PageView.builder(
//         itemCount: movies.length,
//         controller: PageController(
//             initialPage: initialIndex), // Start at the selected movie
//         itemBuilder: (context, index) {
//           final movie = movies[index];
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Hero(
//                   tag: 'now_playing-${movie.id}',
//                   child: Image.network(
//                     'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   movie.title,
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   movie
//                       .overview, // Assuming your Movie model has an overview field
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
