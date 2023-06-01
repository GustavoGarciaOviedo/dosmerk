import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

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
              Text('Cinemapedia', style: titleStyle,),
              const Spacer(),//da el espacio maximoo posible
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.search)
              )
            ],

          )
        )
      )
    );
  }
}