import 'package:dosmerk/domain/datasources/local_storage_datasource.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource{

  late Future<Isar> db;


  IsarDatasource(){
    db = openDB();//metodo
  }

  Future<Isar> openDB()async{
    final dir = await getApplicationDocumentsDirectory();
    if(Isar.instanceNames.isEmpty){
      return await Isar.open([MovieSchema],directory: dir.path, inspector: true);//inspector analisa como esta la bbdd lcal en el dispositivo
    }
    return Future.value(Isar.getInstance());
  }

  @override

  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie =  await isar.movies  ///este movie sacado del esquema
    .filter()
    .idEqualTo(movieId)
    .findFirst();
  return isFavoriteMovie != null;


  }


  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();
    if(favoriteMovie != null){
      //para borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }
//para insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }

  @override
  Future<List<Movie>> loadMovie({int limit = 10, offset = 0}) async {
    final isar =  await db;

    return isar.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }
}