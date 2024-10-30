//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
//
//
// // void main() => runApp(LoginApp());
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends RegisterPage  {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//    get context => null;
//   // final String _validUsername = 'admin';
//   // final String _validPassword = 'password';
//
//   Future<void> _login() async {
//     String username = _usernameController.text.trim();
//     String password = _passwordController.text.trim();
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.getStringList('name');
//     //final List<String>? name = prefs.getStringList('name');
//     List<String>? formerSavedList = prefs.getStringList('name');
//
//     await prefs.getStringList('name');
//     //final List<String>? name = prefs.getStringList('name');
//     List<String>?SavedList = prefs.getStringList('password');
//
//
//     if (formerSavedList!.contains(username) && SavedList!.contains(password) ) {
//       Navigator.push(context!, MaterialPageRoute(builder: (context) => Page()));
//
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Login Failed'),
//           content: const Text('Invalid username or password.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// class Page extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//                     (Route<dynamic> route) => false,
//               );
//             },
//           )
//         ],
//       ),
//       body: const Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }

import 'package:final2/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constant_color.dart';
import '../login/login/login_bloc.dart';
import '../login/login/login_event.dart';
import '../login/login/login_state.dart';
import '../moviebloc/movie_event.dart';
import '../repository/movie_repository.dart';
import '../navigationbloc/navigation_bloc.dart';
import '../moviebloc/popular_movie_bloc.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Appcolor.red,
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                    create: (context) => NavigationBloc()),
                                BlocProvider(
                                    create: (context) => PopularMovieBloc(
                                        movieRepository)
                                      ..add(
                                          FetchMovies())), // Provide the PopularMovieBloc here
                              ],
                              child: HomeScreen(),
                            )));
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Appcolor.nred),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Appcolor.nred),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Appcolor.nred)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Appcolor.nred),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Appcolor.nred),
                        ),
                        labelStyle: TextStyle(color: Appcolor.nred)),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.red,
                        foregroundColor: Appcolor.white),
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      context.read<LoginBloc>().add(
                            LoginUser(
                              email: email,
                              password: password,
                            ),
                          );
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.red,
                        foregroundColor: Appcolor.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: const Text('Go to Registration'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
