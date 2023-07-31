import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/presentation/delagates/search_movie_delegate.dart';
import 'package:dosmerk/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,//quita el espacio que trae por defecto
      child: Padding(
        padding: const  EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(width: 5,),
              Text('Cine', style: titleStyle,),
              const Spacer(),//da el espacio maximoo posible
              IconButton(
                onPressed: (){

                  final searchedMovies =  ref.read(searchedMoviesProvider);
                  final searchQuery =  ref.read(searchQueryProvider);

                  showSearch<Movie?>(//el delegate trabaja la busqueda
                    
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelgate(
                      initialMovies: searchedMovies,
                      searchMovies:  ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                        // return movieRepository.searchMovies(query);
                        
                      )//esto contiene ese query..  mando la referencia a esa funcion
                    ).then((movie) {
                      if(movie==null)return;
                      context.push('/movie/${movie.id}');
                    });
                }, 
                icon: const Icon(Icons.search)
              )
            ],

          )
        )
      )
    );
  }
}