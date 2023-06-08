import 'package:dosmerk/domain/datasources/movies_datasources.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/domain/repositories/movies_repositoriy.dart';


//para cambiar facilmente los origenes de datos, 
class MovieRepositoryImpl extends MoviesRepository{

   final MoviesDatasource datasource;
   MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page:page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page:page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
   return datasource.getTopRated(page:page);
  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
   return datasource.getUpComing(page:page);
  }

}

/*La clase MovieRepositoryImpl extiende la clase abstracta MoviesRepository, 
lo que significa que debe implementar todos los métodos definidos en la interfaz
MoviesRepository.*/

/* este código define una clase MovieRepositoryImpl que implementa la interfaz MoviesRepository y 
tiene un método getNowPlaying que aún no ha sido implementado. La clase se 
encargará de interactuar con una fuente de datos de películas a través de la propiedad datasource. */