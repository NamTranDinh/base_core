import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

///
/// Helper class for date operations.
///
class DateUtils {
  /// Input:
  /// - [timestamp]: A timestamp value, which can be in seconds or milliseconds.
  ///
  /// Output:
  /// - Returns a DateTime object representing the date and time corresponding
  ///   to the provided timestamp.
  ///
  /// If the [timestamp] is in seconds, it's assumed to be a Unix timestamp (seconds
  /// since January 1, 1970, UTC). If it's in milliseconds, it's assumed to be a
  /// timestamp representing milliseconds since the same epoch.
  static DateTime timestampToDateTime(int timestamp) {
    var adjustedTimestamp = timestamp; // Create a new variable

    if (adjustedTimestamp.toString().length == 13) {
      adjustedTimestamp = adjustedTimestamp ~/ 1000; // Modify the new variable
    }
    return DateTime.fromMillisecondsSinceEpoch(
      adjustedTimestamp * 1000,
      isUtc: true,
    );
  }

  /// Input:
  /// - [timestamp]: A timestamp value, which can be in seconds or milliseconds.
  ///
  /// Output:
  /// - Returns a DateTime object representing the UTC time corresponding to
  ///   the provided timestamp.
  ///
  /// If the [timestamp] is in seconds, it's assumed to be a Unix timestamp (seconds
  /// since January 1, 1970, UTC). If it's in milliseconds, it's assumed to be a
  /// timestamp representing milliseconds since the same epoch.
  static DateTime timestampToUtcDateTime(int timestamp) {
    if (timestamp.toString().length == 13) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    } else {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    }
  }

  /// Input:
  /// - [dateTime]: A DateTime object representing a specific date and time.
  ///
  /// Output:
  /// - Returns a timestamp in seconds since January 1, 1970, in the local timezone
  ///   corresponding to the provided DateTime.
  static int dateTimeToTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  /// Input:
  /// - [utcTimeString]: A UTC time string in the format "yyyy-MM-ddTHH:mm:ss.SSSSSS+00:00".
  /// - [timeZoneOffsetHours]: The timezone offset in hours, e.g., -5 for Eastern Standard Time.
  ///
  /// Output:
  /// - Returns a local time string in the format "yyyy-MM-ddTHH:mm:ss.SSSSSS".
  static String utcTimeToLocalByTimezone(
    String utcTimeString,
    int timeZoneOffsetHours,
  ) {
    final utcDateTime = DateTime.parse(utcTimeString);
    final localDateTime = utcDateTime.add(Duration(hours: timeZoneOffsetHours));
    final localTimeFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS");
    final localTimeString = localTimeFormatter.format(localDateTime);
    return localTimeString;
  }

  /// Checks if a given [date] falls on a weekend (Saturday or Sunday).
  ///
  /// Input:
  /// - [date]: A DateTime object representing a specific date.
  ///
  /// Output:
  /// - Returns `true` if the provided date is a Saturday or Sunday; otherwise, returns `false`.
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Checks if a given [date] is in the future or the past compared to the current date and time.
  ///
  /// Input:
  /// - [date]: A DateTime object representing a specific date and time.
  ///
  /// Output:
  /// - Returns an integer:
  ///   - 1 if the provided date is in the future.
  ///   - 0 if the provided date is the same as the current date and time.
  ///   - -1 if the provided date is in the past.
  static int isFutureOrPast(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(now) ? 1 : (date.isAtSameMomentAs(now) ? 0 : -1);
  }

  ///
  /// Calculates the calendar week for the given [date].
  ///
  static int getCalendarWeek(DateTime date) {
    final diff = date.difference(DateTime(date.year, 1, 1));
    final diffInDays = diff.inDays;
    return ((diffInDays - date.weekday + 10) / 7).floor();
  }

  /// Formats a DateTime to a string using a specified formatter.
  ///
  /// If [dateTime] is null, the current DateTime will be used.
  /// If [formatter] is null, the default format 'dd/MM/yyyy' will be used.
  ///
  /// Returns the formatted DateTime string.
  static String formatDateTimeToString({
    DateTime? dateTime,
    String? formatter,
  }) {
    final currentDateTime = dateTime ?? DateTime.now();

    if (formatter != null) {
      return DateFormat(formatter).format(currentDateTime);
    } else {
      return DateFormat('dd/MM/yyyy').format(currentDateTime);
    }
  }

  /// Parses a string representing a date and time into a [DateTime] object.
  ///
  /// The [dateString] should be in the format: 'dd MMM yyyy, h:mm a'.
  ///
  /// If parsing fails, it returns the current DateTime.
  ///
  /// Example:
  /// ```dart
  /// String dateString = '16 Dec 2022, 9:30 pm';
  /// DateTime dateTime = stringToDateTime(dateString);
  /// print(dateTime); // Output: 2022-12-16 21:30:00.000
  /// ```
  static DateTime formatStringToDateTime({String? dateString}) {
    try {
      final date = dateString ??
          formatDateTimeToString(
            formatter: 'dd MMM yyyy, h:mm a',
          );
      final formatter = DateFormat('dd MMM yyyy, h:mm a');
      return formatter.parse(date);
    } on Exception catch (e) {
      print('Error parsing DateTime: $e');
      return DateTime.now();
    }
  }

  /// Generates a list of time strings between the given [beginTime] and [endTime]
  /// with the specified [step] in minutes.
  ///
  /// Input:
  /// - [beginTime]: DateTime(2024, 1, 1, 10, 0) - 10:00AM.
  /// - [endTime]: DateTime(2024, 1, 1, 17, 0) - 5:00PM
  /// - [step]: 30 (30 minutes).
  ///
  /// Output:
  /// - Returns a list of time strings in the format "hh:mm a" (e.g., "10:00 AM").
  ///   => [10:00 AM, 10:30 AM, 11:00 AM, 11:30 AM, 12:00 PM, 12:30 PM, 1:00 PM, 1:30 PM, 2:00 PM, 2:30 PM, 3:00 PM, 3:30 PM, 4:00 PM, 4:30 PM, 5:00 PM]
  static List<String> generateTimeList({
    required DateTime beginTime,
    required DateTime endTime,
    required int step,
    String? locale,
  }) {
    if (step >= 60) {
      throw Exception('Invalid step value. Step must be less than 60 minutes.');
    }

    final times = <String>[];

    var currentTime = beginTime;

    while (currentTime.isBefore(endTime)) {
      final formattedTime = DateFormat(
        'hh:mm a',
        locale ?? 'en_US',
      ).format(currentTime);
      times.add(formattedTime);

      currentTime = currentTime.add(Duration(minutes: step));
    }

    final formattedEndTime = DateFormat(
      'hh:mm a',
      locale ?? 'en_US',
    ).format(endTime);
    times.add(formattedEndTime);

    return times;
  }

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
