

import 'package:dosmerk/infrastructure/models/moviedb/credits_response.dart';

import '../../domain/entities/actor.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast) =>
  Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null
        ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        :'https://upload.wikimedia.org/wikipedia/commons/3/34/PICA.jpg',
    character: cast.character
    );
}