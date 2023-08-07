import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie>movies;//donde llame la clase me exije la pelicula, el llamado
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors =  Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        pagination: SwiperPagination(//los puntos de decoracion...recordar que cardswiper u otro lo hace por defecto
          margin: const EdgeInsets.only(top: 0),//sepra lo spuntos asi no mas ocn 0
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          )
        ),
        viewportFraction: 0.8,
        scale: 0.8,
        autoplayDelay: 10000,
        // autoplay: true,
        autoplayDisableOnInteraction: true, // Detiene el autoplay al interactuar con el swiper
        duration: 2000,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
        ),
      

    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
         color: Colors.black54,
         blurRadius: 2,
         offset: Offset(1, 5)

        )
      ],
      
    );
    return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: DecoratedBox(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.backdropPath,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress !=null){
              return const CircularProgressIndicator();
            }
            return FadeIn (child: child);
          },
          )
        ),
      ),
    );
  }
}