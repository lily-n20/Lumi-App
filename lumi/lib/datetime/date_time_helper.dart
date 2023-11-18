//method to help get date
//converrt Datetime object to a string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  } 

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //combine
  String mmddyyyy = month + day + year;

  return mmddyyyy;
}

/*
DateTime.now()
*/ 