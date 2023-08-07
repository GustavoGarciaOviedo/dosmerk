

import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//provider para peliculas en estreno
final nowPlayingMoviesProvider =  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


//provider para peliculas populares
final popularMoviesProvider =  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


//TODo: anexar par las peliculas proximas a salir y las mas votadas

//provider para peliculas toprated mas valoradas
final topRatedMoviesProvider =  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

//provider para peliculas up coming que van llegando
final upComingMoviesProvider =  StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<Movie>> Function ({int page});

class MoviesNotifier extends StateNotifier <List<Movie>>{

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier(
    {required this.fetchMoreMovies,}
  ): super([]);//proporcina un listado de movie

  Future<void> loadNextPage() async{
    if(isLoading) return;//bloqueo para queno se siga haciendo la peticion
    isLoading = true;
    currentPage++;
    //print('peticion: $currentPage');
    final List<Movie> movies =  await fetchMoreMovies(page:currentPage);
    state = ([...state, ...movies]);
    await Future.delayed(const Duration(milliseconds: 300));//es mejor que espere para que no se dispare de a dos
    isLoading = false;
  }//hacer una modificacion al state

}