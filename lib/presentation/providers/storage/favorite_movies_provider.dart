

import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/domain/repositories/local_storage_repository.dart';
import 'package:dosmerk/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';





final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int,Movie>>((ref) {
  
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return  StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});


class StorageMoviesNotifier extends StateNotifier <Map<int,Movie>>{

  int page=0;

  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository
    }):super({});

  Future <List<Movie>> loadNextPage() async{
    final movies = await localStorageRepository.loadMovie(offset: page *10, limit: 20);//limit 20 seria lo ideal ...por 10 porque quiero que se carguen de a diez
    page++;

    final tempMoviesMap = <int, Movie>{};//esto por ue no quiero hacer multiples llamados para el stado
    for(final movie in movies){
      tempMoviesMap[movie.id]=movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;//regreso las peliculas que vienen de la peticion
  }

  Future<void> toggleFavorite (Movie movie)async{

    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieFavorite = state[movie.id] !=null;

    if(isMovieFavorite){
      state.remove(movie.id);
      state= {...state};
    }else{
      state={...state, movie.id: movie};
    }


  }

}