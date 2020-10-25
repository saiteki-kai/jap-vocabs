class Date {
  static String format(DateTime date, {bool full = false, bool time = false}) {
    if (date == null) return null;

    var timeFormat = "${date.hour.toString().padLeft(2, '0')}時"
        "${date.minute.toString().padLeft(2, '0')}分";

    if (full) {
      if (time) {
        return '${date.year}年${date.month}月${date.day}日 $timeFormat';
      }
      return '${date.year}年${date.month}月${date.day}日';
    }

    var diffToday = Date.endOfDay.difference(date);
    var diffNow = date.difference(DateTime.now());

    if (diffNow.inMilliseconds <= 0) return '今';

    if (diffNow.inDays < 2) {
      if (diffToday.inHours > 0 && diffToday.inHours <= 24) {
        return timeFormat;
      } else {
        return '明日';
      }
    }

    if (diffNow.inDays > 1 && diffNow.inDays <= 7) return '${diffNow.inDays}日';

    if (diffNow.inDays > 7 && diffNow.inDays < 30) {
      return '${(diffNow.inDays / 7).floor()}週';
    }

    if (diffNow.inDays >= 30 && diffNow.inDays < 364) {
      return '${(diffNow.inDays / 30).floor()}月';
    }

    if (diffNow.inDays >= 364) return '${(diffNow.inDays / 364).floor()}年';

    return date.toString();
  }

  static DateTime get endOfDay {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 24, 59, 59);
  }
}
