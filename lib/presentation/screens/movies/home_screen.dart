
// import 'package:dosmerk/config/constants/environment.dart';
// import 'package:dosmerk/presentation/providers/providers.dart';
import 'package:dosmerk/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
static const name = 'home-screen';
final int pageIndex;

  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  final viewRoutes= const <Widget>[
    HomeView(),
    FavoriteView(),

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: IndexedStack (//este es le que va a cambiar las paginas
        index: pageIndex,
        children: viewRoutes,//viewroutes es una array de widgets por eso omito las llaves []
      ),
      
      bottomNavigationBar: 
      CustomBottomNavigator(currentIndex: pageIndex ) ,
      );
  }
}
