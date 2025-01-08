import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AppDateUtils {
  static String timestampToDateString(int timestamp) {
    final DateTime date;
    final is13Characters = timestamp.toString().length == 13;
    if (is13Characters) {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String timeStampToTimeString(int timestamp) {
    final format = DateFormat('HH:mm');
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  static DateTime timestampToDateTime(int timestamp) {
    final DateTime date;
    final is13Characters = timestamp.toString().length == 13;
    if (is13Characters) {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }
    return date;
  }

  static int dateToTimestamp(String dateStr) {
    final formatter = DateFormat('dd/MM/yyyy');
    final date = formatter.parse(dateStr);
    return date.millisecondsSinceEpoch;
  }

  static DateTime toDateTime(String date) {
    final dateSplit = date.split('/');
    final day = int.parse(dateSplit[0]);
    final month = int.parse(dateSplit[1]);
    final year = int.parse(dateSplit[2]);
    return DateTime.utc(year, month, day);
  }

  static String timestampToDate12Numbers(int timestamp) {
    final DateTime date;
    date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    final firstDayOfWeek = dateTime.subtract(
      Duration(days: dateTime.weekday - 1),
    );
    return DateTime(
      firstDayOfWeek.year,
      firstDayOfWeek.month,
      firstDayOfWeek.day,
    );
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    final lastDayOfWeek = dateTime.add(
      Duration(days: DateTime.daysPerWeek - dateTime.weekday),
    );
    return DateTime(
      lastDayOfWeek.year,
      lastDayOfWeek.month,
      lastDayOfWeek.day,
      23,
      59,
      59,
    );
  }

  static DateTime findFirstDateOfNextWeek(DateTime dateTime) {
    final sameWeekDayOfNextWeek = dateTime.add(
      const Duration(days: 7),
    );
    return findFirstDateOfTheWeek(sameWeekDayOfNextWeek);
  }

  static DateTime findLastDateOfNextWeek(DateTime dateTime) {
    final sameWeekDayOfNextWeek = dateTime.add(
      const Duration(days: 7),
    );
    return findLastDateOfTheWeek(sameWeekDayOfNextWeek);
  }

  static String dateTimeToString(
    DateTime dateTime, {
    String? format,
    bool toIso8601String = false,
  }) {
    return toIso8601String
        ? dateTime.toIso8601String()
        : DateFormat(format ?? 'yyyy-MM-dd\'T\'HH:mm:ss.SSSZ')
            .format(dateTime.toUtc());
  }

  static String dateTimeToTimeString(DateTime dateTime, {String? format}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return DateFormat(format ?? 'yyyy-MM-dd\'T\'HH:mm:ss').format(dateTime);
    }
  }

  static bool compareDate(DateTime firstDate, DateTime twoDate) {
    final firstTime = firstDate.millisecondsSinceEpoch;
    final twoTime = twoDate.millisecondsSinceEpoch;
    if (firstTime > twoTime) {
      return true;
    } else {
      return false;
    }
  }

  static DateTime convertStringDateByTimeZone({
    required String date,
    String? timeZoneString,
  }) {
    try {
      final createdAt = DateTime.parse(date);

      final timeZone = tz.getLocation(timeZoneString ?? 'Asia/Singapore');

      final localCreatedAt = tz.TZDateTime.from(createdAt, timeZone);

      return localCreatedAt;
    } on Exception {
      try {
        final formatter = DateFormat('yyyy-MM-dd  HH:mm:ss');

        final parsedDateTime = formatter.parse(date);

        return parsedDateTime;
      } on Exception {
        return DateTime.now();
      }
    }
  }

  static DateTime convertDateTimeByTimeZone({
    required DateTime date,
    String? timeZoneString,
  }) {
    try {
      final timeZone = tz.getLocation(timeZoneString ?? 'Asia/Singapore');

      final localCreatedAt = tz.TZDateTime.from(date, timeZone);

      return localCreatedAt;
    } on Exception {
      return DateTime.now();
    }
  }

  static DateTime convertDateTimeUtcByDateTimeSing({
    required DateTime date,
  }) {
    try {
      const singaporeOffset = Duration(hours: 8);
      final newDate = date.add(singaporeOffset);
      return newDate;
    } on Exception {
      return DateTime.now();
    }
  }
}
