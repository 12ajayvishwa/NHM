import 'package:intl/intl.dart';

class TimeFormateMethod{

   getTimeFormate({time, formate='yyyy-MM-dd HH:mm:ss'}) {
    // Extracting time from the DateTime object
    DateTime inputDatetime = DateTime.parse(time).toLocal();
    String formattedDatetime = DateFormat(formate).format(inputDatetime);
    return formattedDatetime;
  }
}