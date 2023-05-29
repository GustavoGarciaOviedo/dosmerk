

import 'package:dosmerk/infrastructure/datasources/moviedb_datasource.dart';
import 'package:dosmerk/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//el provier llamara MovieRepositoryImpl(le asigno de donde estoy trayendo los datos)'ahi est al apeticion'
final movieRepositoryProvider = Provider((ref)  {
  return MovieRepositoryImpl(MovieDbDatasource());
});