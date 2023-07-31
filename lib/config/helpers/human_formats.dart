
import 'package:intl/intl.dart';

class HumanFormats {

  static String number(double number,[int decimals = 0]){//hubo modificacion era 0 por defecto, coloque la opcion de cambiar la cantidad de decimales
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);
    return formattedNumber;

  }
}