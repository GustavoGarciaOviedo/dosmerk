
import 'package:dio/dio.dart';

import 'package:dosmerk/config/constants/environment.dart';
import 'package:dosmerk/domain/datasources/movies_datasources.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/infrastructure/mappers/movie_mapper.dart';
import 'package:dosmerk/infrastructure/models/moviedb/moviedb_response.dart';
// esta clase es la que lee el mapper que es el que hace el empalme de mi modelo con el modelo que llega de la api
class MovieDbDatasource extends MoviesDatasource{
//la peticion utilzando dio en lugar de http
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-ES'
    }
    )
    );
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    final response = await dio.get('/movie/now_playing');//ojo que es el path ,la categoria(segmento) mejor dicho
    final movieDBResponse = MovieDbResponse.fromJson(response.data);//convertir los datos de la respuesta en un objeto
    final List<Movie> movies= movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')//si no tinen poster no me la muestre
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();//la data que llega la trasformo o 
      //la uso a manera como yo la tengo en Movie  utilizando el mapeador MovieMapper.movieDBToEntity.

    return movies;
  }

}

