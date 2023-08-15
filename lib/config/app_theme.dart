

import 'package:flutter/material.dart';

class Apptheme {
  ThemeData getTheme()=> ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const  Color(0xFF2862F5),
  );
}


// class Apptheme {
//   ThemeData getTheme({bool isDarkMode = false}) {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: isDarkMode
//           ? ColorScheme.dark(
//               primary: const Color(0xFF2862F5),
//               // Otros colores y configuraciones para el tema oscuro
//             )
//           : ColorScheme.light(
//               primary: const Color(0xFF2862F5),
//               // Otros colores y configuraciones para el tema claro
//             ),
//       // Otros ajustes de tema generales
      
//     );
//   }
// }

//se puede utilizar para definir el tema de la aplicación en el archivo principal main.dart 
//o en cualquier otro archivo donde se requiera una definición de tema. Al llamar al método 
//getTheme() de esta clase, se puede obtener un objeto ThemeData con las propiedades especificadas.