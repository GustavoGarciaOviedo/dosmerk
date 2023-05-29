import '../entities/movie.dart';


//los repositorios son los que llaman el data source
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}