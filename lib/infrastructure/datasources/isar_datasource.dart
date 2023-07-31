import 'package:dosmerk/domain/datasources/local_storage_datasource.dart';
import 'package:dosmerk/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource{
  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovie({int limit = 10, offset = 0}) {
    // TODO: implement loadMovie
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

}