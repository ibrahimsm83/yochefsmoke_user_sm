import 'package:intl/intl.dart';

class DateTimeManager{

  static const String dateTimeFormat24="yyyy-MM-dd HH:mm:ss";
  static const String dateTimeFormat="yyyy-MM-dd hh:mm aa";
  static const dateFormat="yyyy-MM-dd";

  static const dateFormat2="dd MMM, yyyy";

  static DateTime parseDateTime24(String date,{String format=dateTimeFormat24,bool isutc=false,}){
    DateTime dateTime=DateFormat(format).parse(date,isutc,);
    return isutc?dateTime.toLocal():dateTime;
  }

  static String getFormattedDateTime(String date,{bool isutc=false,
    String format=dateTimeFormat,String format2=dateTimeFormat24}){
    return DateFormat(format).format(parseDateTime24(date,isutc: isutc,format: format2));
  }

  static String getFormattedDateTimeFromDateTime(DateTime date,{String format=dateTimeFormat,}){
    return DateFormat(format).format(date);
  }

  static String getElapsedTime(int seconds){
    int hours=0,mins=0,secs=0;
    double hh=seconds/3600;
    if(hh>=1){
      hours=hh.toInt();
      seconds=seconds-(3600*hours);
      double mm=seconds/60;
      if(mm>=1){
        mins=mm.toInt();
        secs=seconds-(60*mins);
      }
      else{
        secs=seconds;
      }
    }
    else{
      double mm=seconds/60;
      if(mm>=1){
        mins=mm.toInt();
        secs=seconds-(60*mins);
      }
      else{
        secs=seconds;
      }
    }
    // return "${hours<=9?"0":""}${hours}:${mins<=9?"0":""}${mins}:${secs<=9?"0":""}${secs}";
    return "${mins<=9?"0":""}${mins}:${secs<=9?"0":""}${secs}";
  }
}