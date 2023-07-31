


import 'package:dosmerk/domain/entities/actor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'actors_repository_provider.dart';


final actorsByMovieProvider =  StateNotifierProvider<ActorsByMovieNotifier,Map<String,List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});


typedef GetActorsCallback =  Future<List<Actor>>Function(String movieId);

//'98787808': movie() este es un ejemplo que mira si exuiste ya y si no hace la petiion, es un cache
class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>>{//TODO: si presento problemas con el id de la pelicula es mejor pasarlo entoncesa  tipo string e todas las clases que sigan esete id
  final GetActorsCallback getActors;
  ActorsByMovieNotifier({required this.getActors
  }):super({});

  

  Future<void> loadActors(String movieId)async{
    if(state[movieId]!=null)return;
    print('relaizando peticon htpp $movieId');
    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};


  }

}