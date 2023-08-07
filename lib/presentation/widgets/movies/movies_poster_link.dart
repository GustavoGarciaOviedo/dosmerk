import 'package:animate_do/animate_do.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {

  final Movie movie;
  const MoviePosterLink({
    super.key, 
    required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(//se puede envolver en un faideinup para darle una animacion
      onTap: () => context.push('/home/0/movie/${movie.id}') ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeIn(
          child: Image.network(movie.posterPath)),
      ),
    );
  }
}