
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigator extends StatelessWidget {

  final int currentIndex;
  
  const CustomBottomNavigator({
    super.key, 
    required this.currentIndex, 
    });

  void onItemTapped( BuildContext context, int index){
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/0');//si incluyo algun tengo que estar pendiente a donde me lleva cada ubicacion
        break;//voy a borrar las categorias por un tiempo
      case 2:
        context.go('/home/2');
        break;
      
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(//originalmente estaba solo currentIndex: currentIndex
      currentIndex: currentIndex, //nombrados igual, segun el numero que reciba como parametro que se selecone en la barra de nmavegacion
      elevation: 0,//borra la linea separadora
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'inicio'
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.crop_square, color: Colors.white,),
          label: ''
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'favoritos'
          )
      ]
    );
  }
}