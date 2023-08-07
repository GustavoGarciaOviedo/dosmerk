import 'package:dosmerk/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {

  bool isLastPage = false;
  bool isLoading = false;


    @override
  void initState() {
    super.initState(); // No olvides llamar al método super.initState().
    loadNextPage();
  }

 void loadNextPage()async{
  if (isLoading||isLastPage)return;
  isLoading=true;
  final movies= await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  isLoading = false;

  if(movies.isEmpty){
    isLastPage=true;
  }


 }

  @override

  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();//llamop el provider y lo convierto auna lista


  if (favoriteMovies.isEmpty){
    final colors = Theme.of(context).colorScheme;
    return Center(
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp,size: 70, color: colors.primary,),
          Text('Upss!', style: TextStyle(fontSize: 30, color: colors.primary),),
          const Text('No tienes favoritos', style: TextStyle(fontSize: 20, color: Colors.black45),)
        ],
      ),
    );
  }

    return Scaffold(
      body: 
      // Center(child: Text('data'))
      MovieMasonry(
        loadNextPage:loadNextPage,
        movies: favoriteMovies)
    );
  }
}