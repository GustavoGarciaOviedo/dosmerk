import 'package:animate_do/animate_do.dart';
import 'package:dosmerk/domain/entities/movie.dart';


import 'package:dosmerk/presentation/providers/providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);//widget porque es un stafull
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);//widget porque es un stafull

  }
  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if(movie == null){// solo cuando se cargue la primera vez
      return const Scaffold(
        body:  Center(
          child: CircularProgressIndicator(strokeWidth: 2,),
        ),
      );
    }


    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          _CusmosSliverAppBar(movie: movie,),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie,),
            childCount: 1
            )
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final Movie movie;
  const _MovieDetails({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle =  Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsDirectional.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(movie.posterPath,
                  width: size.width*0.3,
                  ),
                ),
              ),
            const SizedBox(width: 10,),

            //descripcion
            SizedBox(
              width: (size.width-43)*0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold), ),

                  const SizedBox(height: 3,),
                  Text(movie.overview, maxLines: 7,
                  overflow: TextOverflow.ellipsis,),

                ],
              ),
            )//ojo que la dimension esta hardcodeada
    
            ],
          ),

          // gener de las peliculas
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                children: [
                  ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ) )
                ],
              ),
            ),
            _ActorsByMovie(movieId: movie.id.toString(),),
            //TODo: actores
            const SizedBox(height: 20,)

        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({ required this.movieId});

  @override
  Widget build(BuildContext context, ref) {

    final actorsById = ref.watch(actorsByMovieProvider);
    if (actorsById[movieId]==null) {
      return const CircularProgressIndicator(strokeWidth: 2,);
    }

    final actors = actorsById[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              children: [
                //actor
                FadeInRight(
                  from: 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(actor.profilePath,
                    height: 180,
                    width: 135,
                    fit: BoxFit.cover,
                    ),
                    
                  ),
                ),
                //name
                const SizedBox(height: 3,),
                Text(actor.name, maxLines: 1,overflow:TextOverflow.ellipsis,),
                Text(actor.character??'', maxLines: 1,overflow:TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          );
        },
      ),
    );
  }
}

//este es le provider de riverpod que estara pendiente de los favoritos ''corazon''
final isFavoriteProvier =  FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository =  ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
   //si esta en favoritos
});




class _CusmosSliverAppBar extends ConsumerWidget {

  final Movie movie;
  const _CusmosSliverAppBar({ required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isFavoriteFuture = ref.watch(isFavoriteProvier(movie.id));//es el Provider que hara modificar el boton
    
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height*0.7,
      actions: [
       InkResponse(
       //aqui es probable un ontap
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(18, 12, 12, 12),
            
          ),
        child: IconTheme(
          data: const IconThemeData(size: 30.0, color: Colors.white),
          child: IconButton(
            icon: isFavoriteFuture.when(
              data: (isFavorite)=> isFavorite//condicionado segun el estado
              ? const Icon(Icons.favorite_rounded, color: Colors.red,)
              : const Icon(Icons.favorite_border_sharp),
              error: (_,__)=>throw UnimplementedError(), 
              loading: ()=> const  CircularProgressIndicator(strokeWidth: 2,)
              ),
              
            
            onPressed: () async{

              // ref.watch(localStorageRepositoryProvider)
              // .toggleFavorite(movie);

              await ref.read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);
              
              ref.invalidate(isFavoriteProvier(movie.id));
            },
          ),
        ),
        ),
      )

      ],
      foregroundColor: Colors.white,
      
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        // title: Text(
        //   movie.title,
        //   style: TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(movie.posterPath,
                fit:  BoxFit.cover,
                ),
              ),
              const SizedBox.expand(//oscurece la imagen para que el icono se pueda ver mejor
                child: DecoratedBox(decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0,0.3],
                    colors: [
                      Colors.black26,
                      Colors.transparent,
                  ])
                )),
              )
            ],
          ),
      ),
      
    );
  }
}