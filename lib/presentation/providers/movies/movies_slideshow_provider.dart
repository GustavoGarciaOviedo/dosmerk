

import 'package:dosmerk/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final moviesSlidershowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingmovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingmovies.isEmpty) return [];
  return nowPlayingmovies.sublist(0,6);


}) ;