import 'package:animate_do/animate_do.dart';
import 'package:dosmerk/config/helpers/human_formats.dart';
import 'package:dosmerk/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;//opcional poruqe no todas quiero que se generen cuando se cambia la pagina
  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();
  bool isInitialized = false;
  @override
  void initState() {
    super.initState();

    if (!isInitialized && widget.loadNextPage != null) {
      scrollController.addListener(() { 
        if((scrollController.position.pixels+200 )>= scrollController.position.maxScrollExtent){
          print('manda a llamar la funcion');
          widget.loadNextPage!();
        }
      });
      isInitialized = true;
    }
  }
//cada vez que se cree en addListener, se recomienda crear el dispose para evitar la llamadas repetidas
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title !=null || widget.subTitle != null)
          _Title(title: widget.title, subTitle: widget.subTitle,),
          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,//necesito asociarlo para que me indique la posicion
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(//es una am=niacion para que cuando aparezca la imagen se deslice
                  child: _Slide(movie: widget.movies[index]))
                ;
              },
            ),
            ),
    
    
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({ required this.movie });

  @override
  Widget build(BuildContext context) {
// print('${movie.backdropPath} ${movie.posterPath}');
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          //* Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if ( loadingProgress != null ) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2 )),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating
          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.amber.shade700,),
              const SizedBox(width: 3,),
              Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.amber.shade800),),
              const SizedBox(width: 10,),
              Text(HumanFormats.number(movie.popularity),style: textStyles.labelMedium),//el format lo creo como clase por si llego a requerirlo en alguna odificacion
             
            ],
          )



        ],
      ),
    );
  }
}




class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({ 
    this.title, 
    this.subTitle});


  @override
  Widget build(BuildContext context) {

    final titleStyle =  Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          if(title != null) Text('$title', style: titleStyle,),
          const Spacer(),
          if(subTitle != null) FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){}, 
            child: Text('$subTitle'))
        ],
      ),
    );
  }
}