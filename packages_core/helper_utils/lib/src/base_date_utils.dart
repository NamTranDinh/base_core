import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AppDateUtils {
  static String timestampToDate(int timestamp) {
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

  static String timeStampToTime(int timestamp) {
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

  static String convertDateFromDataApi(String data) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final inputDate = inputFormat.parse(data);

    final outputFormat = DateFormat('dd-MM-yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static DateTime toMidnight(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    var now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  static bool isPastDay(DateTime? date) {
    if (date == null) return false;
    var today = toMidnight(DateTime.now());
    return date.isBefore(today);
  }

  static int convertToMin(String hrmin) {
    var tokens = hrmin.split(":");
    int minutes = 0;
    for (int i = tokens.length; i > 0; i--) {
      int value = int.parse(tokens[i - 1]);
      if (i == 1) {
        minutes += 60 * value;
      } else {
        minutes += value;
      }
    }
    return minutes;
  }

  static DateTime addDaysToDate(DateTime date, int days) {
    DateTime newDate = date.add(Duration(days: days));

    if (date.hour != newDate.hour) {
      var hoursDifference = date.hour - newDate.hour;

      if (hoursDifference <= 3 && hoursDifference >= -3) {
        newDate = newDate.add(Duration(hours: hoursDifference));
      } else if (hoursDifference <= -21) {
        newDate = newDate.add(Duration(hours: 24 + hoursDifference));
      } else if (hoursDifference >= 21) {
        newDate = newDate.add(Duration(hours: hoursDifference - 24));
      }
    }
    return newDate;
  }

  static DateTime getFirstDayOfCurrentMonth() {
    var dateTime = DateTime.now();
    dateTime = getFirstDayOfMonth(dateTime);
    return dateTime;
  }

  static DateTime getFirstDayOfNextMonth() {
    var dateTime = getFirstDayOfCurrentMonth();
    dateTime = addDaysToDate(dateTime, 31);
    dateTime = getFirstDayOfMonth(dateTime);
    return dateTime;
  }

  static DateTime getLastDayOfCurrentMonth() {
    return getLastDayOfMonth(DateTime.now());
  }

  static DateTime getLastDayOfNextMonth() {
    return getLastDayOfMonth(getFirstDayOfNextMonth());
  }

  static DateTime addMonths(DateTime fromMonth, int months) {
    DateTime firstDayOfCurrentMonth = fromMonth;
    for (int i = 0; i < months; i++) {
      firstDayOfCurrentMonth =
          getLastDayOfMonth(firstDayOfCurrentMonth).add(Duration(days: 1));
    }

    return firstDayOfCurrentMonth;
  }

  static DateTime getFirstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime getLastDayOfMonth(DateTime month) {
    DateTime firstDayOfMonth = DateTime(month.year, month.month);
    DateTime nextMonth = firstDayOfMonth.add(Duration(days: 32));
    DateTime firstDayOfNextMonth = DateTime(nextMonth.year, nextMonth.month);
    return firstDayOfNextMonth.subtract(Duration(days: 1));
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  static bool isCurrentMonth(DateTime date) {
    var now = DateTime.now();
    return date.month == now.month && date.year == now.year;
  }

  static int calculateMaxWeeksNumberMonthly(
    DateTime startDate,
    DateTime endDate,
  ) {
    int monthsNumber = calculateMonthsDifference(startDate, endDate);

    List<int> weeksNumbersMonthly = <int>[];

    if (monthsNumber == 0) {
      return calculateWeeksNumber(startDate, endDate);
    } else {
      weeksNumbersMonthly.add(
        calculateWeeksNumber(startDate, getLastDayOfMonth(startDate)),
      );

      DateTime firstDateOfMonth = getFirstDayOfMonth(startDate);
      for (int i = 1; i <= monthsNumber - 2; i++) {
        firstDateOfMonth = firstDateOfMonth.add(Duration(days: 31));
        weeksNumbersMonthly.add(
          calculateWeeksNumber(
            firstDateOfMonth,
            getLastDayOfMonth(firstDateOfMonth),
          ),
        );
      }

      weeksNumbersMonthly.add(
        calculateWeeksNumber(getFirstDayOfMonth(endDate), endDate),
      );

      weeksNumbersMonthly.sort((a, b) => b.compareTo(a));
      return weeksNumbersMonthly[0];
    }
  }

  static int calculateMonthsDifference(DateTime startDate, DateTime endDate) {
    var yearsDifference = endDate.year - startDate.year;
    return 12 * yearsDifference + endDate.month - startDate.month;
  }

  static int calculateWeeksNumber(
      DateTime monthStartDate, DateTime monthEndDate) {
    int rowsNumber = 1;

    DateTime currentDay = monthStartDate;
    while (currentDay.isBefore(monthEndDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday == DateTime.monday) {
        rowsNumber += 1;
      }
    }

    return rowsNumber;
  }

  /// Example usage:

  /// DateTime now = DateTime.now();
  /// String defaultFormatted = formatDateTime(now);
  /// print(defaultFormatted); // Output: "2024-05-26T00:00:00.000-0700"

  /// String customFormatted = formatDateTime(now, format: 'yyyy-MM-dd HH:mm:ss');
  /// print(customFormatted); // Output: "2024-05-26 00:00:00"

  /// Calculates the first date of the week that a given [DateTime] object belongs to.
  ///
  /// @param dateTime The [DateTime] object to find the first date of the week for.
  /// @return The first date of the week (Monday) at 00:00:00 that the input [DateTime] belongs to.
  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    DateTime firstDayOfWeek = dateTime.subtract(
      Duration(days: dateTime.weekday - 1),
    );
    return DateTime(
      firstDayOfWeek.year,
      firstDayOfWeek.month,
      firstDayOfWeek.day,
      0,
      0,
      0,
    );
  }

  /// Example usage:

  /// DateTime now = DateTime.now();
  /// String defaultFormatted = formatDateTime(now);
  /// print(defaultFormatted); // Output: "2024-05-26T00:00:00.000-0700"

  /// Calculates the last date of the week that a given [DateTime] object belongs to.

  /// @param dateTime The [DateTime] object to find the last date of the week for.
  /// @return The last date of the week (Sunday) at 23:59:59 that the input [DateTime] belongs to.
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

  static DateTime findFirstDateOfPreviousWeek(DateTime dateTime) {
    final DateTime sameWeekDayOfLastWeek = dateTime.subtract(
      const Duration(days: 7),
    );
    return findFirstDateOfTheWeek(sameWeekDayOfLastWeek);
  }

  static DateTime findFirstDateOfNextWeek(DateTime dateTime) {
    final DateTime sameWeekDayOfNextWeek = dateTime.add(
      const Duration(days: 7),
    );
    return findFirstDateOfTheWeek(sameWeekDayOfNextWeek);
  }

  static DateTime findLastDateOfNextWeek(DateTime dateTime) {
    final DateTime sameWeekDayOfNextWeek = dateTime.add(
      const Duration(days: 7),
    );
    return findLastDateOfTheWeek(sameWeekDayOfNextWeek);
  }

  /// Formats a [DateTime] to a string in the specified or default format.
  ///
  /// @param dateTime The [DateTime] to format.
  /// @param format (optional) The desired date and time format as a [String].
  ///   Defaults to 'yyyy-MM-dd'T'HH:mm:ss.SSSZ' if not provided.
  /// @param toIso8601String (optional) Whether to format the output in ISO 8601.
  ///   If `true`, the `format` parameter is ignored.
  /// @return The formatted [DateTime] as a [String].
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

  /// Formats a [DateTime] to a string in the specified or default format.
  ///
  /// If the [DateTime] is less than 1 minute ago, returns 'just now'.
  /// If the [DateTime] is less than 1 hour ago, returns the number of minutes ago.
  /// If the [DateTime] is less than 1 day ago, returns the number of hours ago.
  /// Otherwise, returns the formatted date and time string.
  ///
  /// @param dateTime The [DateTime] to format.
  /// @param format (optional) The desired date and time format as a [String].
  ///   Defaults to 'yyyy-MM-dd'T'HH:mm:ss' if not provided.
  /// @return The formatted [DateTime] as a [String].
  static String dateTimeToStringTime(DateTime dateTime, {String? format}) {
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

  /// Converts a string to a [DateTime] object.
  ///
  /// @param dateTimeString The string to be converted to a [DateTime] object.
  /// @param [format] The format of the input [dateTimeString]. If not provided, the function will try to parse the string using the following formats:
  /// @return The [DateTime] object corresponding to the input string, or `null` if the string cannot be parsed.
  static DateTime? stringToDateTime(String? dateTimeString, [String? format]) {
    if (dateTimeString == null) return null;
    try {
      if (format != null) {
        return DateFormat(format).parseStrict(dateTimeString);
      } else {
        try {
          return DateTime.parse(dateTimeString);
        } catch (e) {
          try {
            return DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ")
                .parseStrict(dateTimeString);
          } catch (e) {
            return DateFormat("yyyy-MM-dd\'T\'HH:mm:ss.SSSZ")
                .parseStrict(dateTimeString);
          }
        }
      }
    } catch (e) {
      return null;
    }
  }

  static bool compareDate(DateTime firstDate, DateTime twoDate) {
    var firstTime = firstDate.millisecondsSinceEpoch;
    var twoTime = twoDate.millisecondsSinceEpoch;
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
      final DateTime createdAt = DateTime.parse(date);

      final timeZone = tz.getLocation(timeZoneString ?? 'Asia/Singapore');

      final localCreatedAt = tz.TZDateTime.from(createdAt, timeZone);

      return localCreatedAt;
    } catch (e) {
      try {
        final formatter = DateFormat('yyyy-MM-dd  HH:mm:ss');

        final parsedDateTime = formatter.parse(date);

        return parsedDateTime;
      } catch (e) {
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
      print(date);
      print(timeZone);

      final localCreatedAt = tz.TZDateTime.from(date, timeZone);

      return localCreatedAt;
    } catch (e) {
      print(e);
      return DateTime.now();
    }
  }

  static DateTime convertDateTimeUtcByDateTimeSing({
    required DateTime date,
  }) {
    try {
      const singaporeOffset = Duration(hours: 8);
      DateTime newDate = date.add(singaporeOffset);
      return newDate;
    } catch (e) {
      print(e);
      return DateTime.now();
    }
  }
}
