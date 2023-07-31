

import 'package:dosmerk/domain/entities/movie.dart';

import 'package:dosmerk/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository =  ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovies, 
    ref: ref
    );
});
typedef SearchMoviesCallback = Future <List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier <List<Movie>>{

  final SearchMoviesCallback searchMovies;
  final Ref ref;
  SearchedMoviesNotifier( {
    required this.searchMovies, 
    required this.ref})
    :super([]);//se inicialixza como un arreglo vacio

  Future <List<Movie>> searchMoviesByQuery(String query) async{

    final List<Movie> movies= await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state=movies;//se mantien ele ultimo resultado de busqueda. no se utiliza... porque no quiero todas si no que se sobreescriba


    return movies;
  }

}