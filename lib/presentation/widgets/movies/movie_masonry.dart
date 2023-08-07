import 'package:dosmerk/domain/entities/movie.dart';
import 'package:dosmerk/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {


  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key, 
    required this.movies, 
    this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final scrollcontroller =  ScrollController();

//init
@override
  void initState() {
    super.initState();
    scrollcontroller.addListener(() {
      if(widget.loadNextPage==null)return;

      if((scrollcontroller.position.pixels +100) >= scrollcontroller.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }
//dispose

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollcontroller,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        crossAxisCount: 3, //las columnas del caso
        itemBuilder: (context, index){

          if(index == 1 ){
            return Column(
              children: [
                const SizedBox(height: 20,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}