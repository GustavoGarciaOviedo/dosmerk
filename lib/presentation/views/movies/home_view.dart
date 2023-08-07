
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
   const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();//este es el puente que va a llamar la siguiente pagina
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlidershowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);


    
    return Visibility(//no es necesario para el caso pero sirve si ya estan las imagenes pero quiero que termine la peticion,como  para ponerlas en el fondo con un stack
      visible: !initialLoading,
      child: CustomScrollView(//en lugar singlechilscrolview 
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    MoviesSlideshow(movies: slideShowMovies),
                    //en carterlera
                    MovieHorizontalListview(
                      movies:nowPlayingMovies ,
                      title: 'En Cines',
                      //subTitle: 'Fecha',
                      loadNextPage: () {
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();//esta funcion se llama cuando el scroll se acerca al maxionm de la carga de la pantalla que va en 20 peluculas
                      },
                    ),
                    const SizedBox(height: 10,),
                      //las populares pero son las mismas que en cartelera
                      MovieHorizontalListview(
                        movies:popularMovies,
                        title: 'Populares',
                        //subTitle: 'en este mes',
                        loadNextPage: () {
                          ref.read(popularMoviesProvider.notifier).loadNextPage();//esta funcion se llama cuando el scroll se acerca al maxionm de la carga de la pantalla que va en 20 peluculas
                        },
                      ),
                     const SizedBox(height: 10,),                 
                      //toprated las mas valoradas
                      MovieHorizontalListview(
                        movies:topRatedMovies,
                        title: 'Mas Valoradas',
                        //subTitle: 'En temporada',
                        loadNextPage: () {
                          ref.read(topRatedMoviesProvider.notifier).loadNextPage();//esta funcion se llama cuando el scroll se acerca al maxionm de la carga de la pantalla que va en 20 peluculas
                        },
                      ),
                      const SizedBox(height: 10,),
                      //las que van a llegar upcoming
                      MovieHorizontalListview(
                        movies:upComingMovies,
                        title: 'Proximamente',
                        //subTitle: 'En Espera',
                        loadNextPage: () {
                          ref.read(upComingMoviesProvider.notifier).loadNextPage();//esta funcion se llama cuando el scroll se acerca al maxionm de la carga de la pantalla que va en 20 peluculas
                        },
                      ),
                      const SizedBox(height: 10,),
                  ]
                );
              },
              childCount: 1)
          )
        ],
      ),
    );
  }
}