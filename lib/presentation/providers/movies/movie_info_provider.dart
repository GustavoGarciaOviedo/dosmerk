


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../providers.dart';


final movieInfoProvider =  StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref) {
  final moviesRepository = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: moviesRepository);
});


typedef GetMovieCallback =  Future<Movie>Function(String movieId);

//'98787808': movie() este es un ejemplo que mira si exuiste ya y si no hace la petiion, es un cache
class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{//TODo: si presento problemas con el id de la pelicula es mejor pasarlo entoncesa  tipo string e todas las clases que sigan esete id
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie
  }):super({});

  

  Future<void> loadMovie(String movieId)async{
    if(state[movieId]!=null)return;
    //print('relaizando peticon htpp $movieId');
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};


  }

}