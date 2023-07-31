

import 'package:dosmerk/infrastructure/models/moviedb/credits_response.dart';

import '../../domain/entities/actor.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast) =>
  Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null
        ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        :'https://img.uxwing.com/wp-content/themes/uxwing/download/peoples-avatars-thoughts/no-profile-picture-icon.png',
    character: cast.character
    );
}