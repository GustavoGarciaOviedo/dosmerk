

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:dosmerk/config/helpers/human_formats.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback =  Future<List<Movie>> Function(String query);

class SearchMovieDelgate extends SearchDelegate<Movie?>{//importo la movie para utilizarla si cierro la busqueda


  final SearchMoviesCallback searchMovies;
   List<Movie> initialMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();//broadcash cuando pueden haber varios widgets escucahndo, y aque funciona a manera de un listener
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelgate(
    {required this.searchMovies, 
    required this.initialMovies,}
    ):super();

    void clearStreams(){
      debounceMovies.close();
    }

    void _onQueryChanged(String query){//cuando deje de escribir por x milise se hace la peticion
      // print('sting cambio');
      isLoadingStream.add(true);
      if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

      _debounceTimer= Timer(const  Duration(milliseconds:600), () async{ 
        // print('peticion hecha');
        // if(query.isEmpty){//si dejo esto activado el primer caracter seguira haciendo la carga
        //   debounceMovies.add([]);
        //   return;
        // }
        final movies = await searchMovies(query);
        debounceMovies.add(movies); 
        initialMovies=movies;
        isLoadingStream.add(false);


      });
    }
    

    Widget _builResultAndSuggestion(){
      return    StreamBuilder(//se cambia a este widget para evitar el multiple llamado,, se hacen correcciones
        initialData: initialMovies,
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return _MovieItem(
                movie: movies[index],
                onMovieSelected: (context, movie){
                  close(context, movie);
                  clearStreams();
                },
                );
            },
          );
        }, 
      );
    }




  @override
  String get searchFieldLabel => 'buscar...';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        initialData: false,
        builder: ( context, snapshot) {
          if(snapshot.data??false){
            return SpinPerfect(//dar vueltas al icono
              duration: const Duration(seconds: 20),
              spins: 10,
              //animate: query.isNotEmpty,
              child: IconButton(onPressed: ()=> query='', 
              icon: const Icon(Icons.refresh_rounded)
              ),
            );
          }
          return  FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(onPressed: ()=> query='', 
            icon: const Icon(Icons.clear)
            ),
          );
        },
      ),

  
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {//para salir
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null); 
      },
      icon: const Icon(Icons.arrow_back_ios_new)
      );
    
  }

  @override
  Widget buildResults(BuildContext context) {
    return _builResultAndSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);//detecta los cambios
   return _builResultAndSuggestion();
  }
}
class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({ required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle =  Theme.of(context).textTheme;
    final size =  MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context,movie);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width*0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),),
              ),
            ),
    
            const SizedBox(width: 10,),
    
          SizedBox(
            width: size.width*0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleMedium,),
                (movie.overview.length>120)
                ?Text('${movie.overview.substring(0,120)}...')
                :Text(movie.overview),
    
                Row(
                  children: [
                    Icon(Icons.star_half_outlined, color: Colors.yellow[800],),
                    const SizedBox(width: 5,),
                    Text(
                      HumanFormats.number(movie.voteAverage,1),//ese numoro equivale a la cantidad de decimales que quiero,.. fuem modificado
                      // movie.voteAverage.toString(),
                      style: textStyle.bodyMedium!.copyWith(color: Colors.yellow[900]),
                      )
                  ],
                )
    
              ]),
          ),
          ],
        ),
      ),
    );

  }
}
