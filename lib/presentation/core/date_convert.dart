class DateConvert {
  static String dateToString(DateTime? date) {
    if (date == null) {
      return "";
    }
    return date.toString().substring(0, 10);
  }
}
