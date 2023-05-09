

import 'package:flutter/material.dart';

class Apptheme {
  ThemeData getTheme()=> ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xFF2862F5),
  );
}

//se puede utilizar para definir el tema de la aplicación en el archivo principal main.dart 
//o en cualquier otro archivo donde se requiera una definición de tema. Al llamar al método 
//getTheme() de esta clase, se puede obtener un objeto ThemeData con las propiedades especificadas.