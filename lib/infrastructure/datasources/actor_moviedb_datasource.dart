

import 'package:dio/dio.dart';
import 'package:dosmerk/domain/datasources/actors_datasource.dart';
import 'package:dosmerk/domain/entities/actor.dart';
import 'package:dosmerk/infrastructure/mappers/actor_mapper.dart';
import 'package:dosmerk/infrastructure/models/moviedb/credits_response.dart';

import '../../config/constants/environment.dart';

class ActorMovieDbDatasource extends ActorsDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-ES'
      }
    )
  );



  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }

}


//la siguiente es una posible solucion cuando no hay internet, esperar si se optimiza
//  @override
// Future<List<Actor>> getActorsByMovie(String movieId) async {
//   Response? response = null; // Valor predeterminado inicial

//   try {
//     response = await dio.get('/movie/$movieId/credits');
//     // Resto del código para procesar la respuesta correctamente
//   } catch (error) {
//     // Manejo del error
//     print('Errorsillo: $error');
//     // Puedes mostrar un mensaje al usuario indicando que no hay conexión a internet
//   }

//   if (response != null) {
//     final castResponse = CreditsResponse.fromJson(response.data);

//     List<Actor> actors = castResponse.cast
//         .map((cast) => ActorMapper.castToEntity(cast))
//         .toList();

//     return actors;
//   } else {
//     // Manejar el caso cuando no se pudo obtener la respuesta
//     return []; // o cualquier otro valor predeterminado
//   }
// }