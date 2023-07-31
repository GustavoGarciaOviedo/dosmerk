//tenemos que instalar en el puspect : go_router   (pusspect assist)

import 'package:go_router/go_router.dart';

import 'package:dosmerk/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';
        return   HomeScreen(pageIndex: int.parse(pageIndex));//parseo el resultado poruqe optine un string aqui y requiere es un int
        },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) { 
            final movieId = state.pathParameters['id'] ?? '';
            return MovieScreen(movieId: movieId,);
          },
        ),
      ]
    ),
    GoRoute(
      path: '/',
      redirect: (_ , __ ) => 'home/0',)
  ]
);