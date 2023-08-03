import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {

  void initState() {
    // aqui llamamos nuestro provider de favoritos
    ref.read(favoriteMoviesProvider.notifier)//para qeu se esuchado necesita el notifier que desbloquea el metodo
    .loadNextPage();
  }

  @override

  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();//llamop el provider y lo convierto auna lista


    return Scaffold(
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie =  favoriteMovies[index];//como el builder es un bucle me guarda en mmovie lo que necesite
          return Text(movie.title);
        },
      ),
    )
    ;
  }
}