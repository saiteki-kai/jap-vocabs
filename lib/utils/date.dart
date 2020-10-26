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

    final millis =
        date.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
        
    if (millis <= 0) return '今';

    final seconds = millis / 1000;
    final hours = seconds / 3600;
    final days = seconds / 86400;
    final months = seconds / 2592000;
    final years = seconds / 31536000;

    if (hours < 24) {
      return timeFormat;
    } else if (hours < 48) {
      return '明日';
    } else if (days < 7) {
      return '${days.round()}日';
    } else if (days < 30) {
      return '${(days / 7).round()}週';
    } else if (days < 365) {
      return '${months.round()}月';
    }

    return '${years.round()}年';
  }
}
