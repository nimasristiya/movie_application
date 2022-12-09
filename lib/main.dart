import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_api/app_constant.dart';
import 'package:movie_api/movie/pages/movie_page.dart';
import 'package:movie_api/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_api/movie/repositories/movie_repository.dart';
import 'package:movie_api/movie/repositories/movie_repository_imp.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.apiKey},
  );

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(App(movieRepository: movieRepository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => sl<MovieGetTopRatedProvider>(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
