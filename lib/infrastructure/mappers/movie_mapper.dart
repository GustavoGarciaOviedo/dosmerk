// lle diferentes modelos y crea mi entidad,, crea una pelicula basada en el tipo de obj que va a recibir

import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/infrastructure/models/moviedb/movie_details.dart';
import 'package:dosmerk/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
        ?'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        :'https://img.freepik.com/free-vector/page-found-concept-illustration_114360-1869.jpg?w=2000',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),//es la manera en que mapeo y convierto a la carrera
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ?'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        :'https://img.freepik.com/free-vector/page-found-concept-illustration_114360-1869.jpg?w=2000',
      releaseDate: moviedb.releaseDate !=null 
        ? moviedb.releaseDate! 
        : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
      );


//TODO: es muy importante saber que este es el acoplamiento y que segun lo que tenga en el modelo 
//o lo que llegue de la api, aqui estara el correspondiente segun mi propio modelo de lo que espero que me llege
// de alguna api
      static Movie movieDetailsToEntity( MovieDetails moviedb) => Movie(
        adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
        ?'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        :'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqxaYHoUue0rXP7uk7hObpCgJ4vdTLBtE0qLIqV3ixdZF0bK8IksSLVZp0npZc4H7F1z8&usqp=CAU',
      genreIds: moviedb.genres.map((e) => e.name).toList(),//es la manera en que mapeo y convierto a la carrera
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ?'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
        :'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqxaYHoUue0rXP7uk7hObpCgJ4vdTLBtE0qLIqV3ixdZF0bK8IksSLVZp0npZc4H7F1z8&usqp=CAU',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
      );
}
