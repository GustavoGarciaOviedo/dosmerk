// lle diferentes modelos y crea mi entidad,, crea una pelicula basada en el tipo de obj que va a recibir

import 'package:dosmerk/domain/entities/movie.dart';
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
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
