
import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,//borra la linea separadora
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'inicio'
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'categorias'
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'favorito'
          )
      ]
    );
  }
}