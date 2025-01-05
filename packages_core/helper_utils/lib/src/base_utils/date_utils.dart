import 'package:intl/intl.dart';

///
/// Helper class for date operations.
///
class DateUtils {
  static const daysOfWeek = 7;
  static const regexMonday = 'mon|Mon|monday|Monday';
  static const regexTuesday = 'tue|Tue|tuesday|Tuesday';
  static const regexWednesday = 'wed|Wed|wednesday|Wednesday';
  static const regexThursday = 'thu|Thu|thursday|Thursday';
  static const regexFriday = 'fri|Fri|friday|Friday';
  static const regexSaturday = 'sat|Sat|saturday|Saturday';
  static const regexSunday = 'sun|Sun|sunday|Sunday';
  static const regexJanuary = 'jan|Jan|january|January';
  static const regexFebruary = 'feb|Feb|february|February';
  static const regexMarch = 'mar|Mar|march|March';
  static const regexApril = 'apr|Apr|april|April';
  static const regexMay = 'may|May';
  static const regexJune = 'june|June';
  static const regexJuly = 'july|July';
  static const regexAugust = 'aug|Aug|august|August';
  static const regexSeptember = 'sep|Sep|september|September';
  static const regexOctober = 'oct|Oct|october|October';
  static const regexNovember = 'nov|Nov|november|November';
  static const regexDecember = 'dec|Dec|december|December';
  static final REGEX_YEAR = RegExp('^(y|year|years)\$');
  static final REGEX_MONTH = RegExp('^(mo|month|months)\$');
  static final REGEX_WEEK = RegExp('^(w|week|weeks)\$');
  static final REGEX_DAY = RegExp('^(d|day|days)\$');
  static final REGEX_HOUR = RegExp('^(h|hour|hours)\$');
  static final REGEX_MINUTES = RegExp('^(m|minute|minutes)\$');
  static final REGEX_SECONDS = RegExp('^(s|second|seconds)\$');
  static final REGEX_MONDAY = RegExp('^($regexMonday)\$');
  static final REGEX_TUESDAY = RegExp('^($regexTuesday)\$');
  static final REGEX_WEDNESDAY = RegExp('^($regexWednesday)\$');
  static final REGEX_THURSDAY = RegExp('^($regexThursday)\$');
  static final REGEX_FRIDAY = RegExp('^($regexFriday)\$');
  static final REGEX_SATURDAY = RegExp('^($regexSaturday)\$');
  static final REGEX_SUNDAY = RegExp('^($regexSunday)\$');
  static final REGEX_JANUARY = RegExp('^($regexJanuary)\$');
  static final REGEX_FEBRUARY = RegExp('^($regexFebruary)\$');
  static final REGEX_MARCH = RegExp('^($regexMarch)\$');
  static final REGEX_APRIL = RegExp('^($regexApril)\$');
  static final REGEX_MAY = RegExp('^($regexMay)\$');
  static final REGEX_JUNE = RegExp('^($regexJune)\$');
  static final REGEX_JULY = RegExp('^($regexJuly)\$');
  static final REGEX_AUGUST = RegExp('^($regexAugust)\$');
  static final REGEX_SEPTEMBER = RegExp('^($regexSeptember)\$');
  static final REGEX_OCTOBER = RegExp('^($regexOctober)\$');
  static final REGEX_NOVEMBER = RegExp('^($regexNovember)\$');
  static final REGEX_DECEMBER = RegExp('^($regexDecember)\$');

  static final REGEX_AM_PM = RegExp(
      '^(\\d{1,2}\\s(pm|am)|\\d{1,2}(\\.|:)\\d{2}\\s(pm|am)|\\d{1,2}(\\.|:)\\d{2}(\\.|:)\\d{2}\\s(pm|am))\$');
  static final REGEX_WEEKDAY = RegExp(
      '^($regexMonday|$regexTuesday|$regexWednesday|$regexThursday|$regexFriday|$regexSaturday|$regexSunday)\$');
  static final REGEX_MONTHS = RegExp(
      '^($regexJanuary|$regexFebruary|$regexMarch|$regexApril|$regexMay|$regexJune|$regexJuly|$regexSeptember|$regexOctober||$regexNovember||$regexDecember)\$');
  static final REGEX_DATE = RegExp(
      '^\\d{1,2}\\s($regexJanuary|$regexFebruary|$regexMarch|$regexApril|$regexMay|$regexJune|$regexJuly|$regexAugust|$regexSeptember|$regexOctober||$regexNovember||$regexDecember)\\s\\d{2,4}.*\$');

  ///
  /// Converts English textual datetime description to a [DateTime] object.
  ///
  /// If [time] is set, it will be used to determine the desired date.
  /// If [time] is null (the default), now is used to determine the date.
  ///
  /// Example :
  /// ```dart
  /// stringToDateTime('yesterday'); // will receive yesterday from now
  /// stringToDateTime('yesterday', time: time); // will receive yesterday from the given date.
  /// ```
  ///
  /// Supported strings:
  /// * now
  /// * \+ 1 year(s)|y 2 month(s)|mo 3 week(s)|w 4 hour(s)|h 5 minute(s)|m 6 second(s)|s
  /// * \- 1 year(s)|y 2 month(s)|mo 3 week(s)|w 4 hour(s)|h 5 minute(s)|m 6 second(s)|s
  /// * yesterday (at 1 pm|1 hour|13:00:00)
  /// * tomorrow (at 1 pm|1 hour|13:00:00)
  /// * last monday (at 1 pm|1 hour|13:00:00)
  /// * next monday (at 1 pm|1 hour|13:00:00)
  /// * 10 September 2019 (at 1 pm|1 hour|13:00:00)
  /// * 1 day(s)|week(s)|month(s) ago
  /// * 2 pm next monday|week
  ///
  static DateTime stringToDateTime(String s, {DateTime? time}) {
    var now = DateTime.now();
    if (s == 'now') {
      return now;
    }
    now = time ?? now;
    if (s.startsWith('+')) {
      return _parseAddRem(s, now);
    } else if (s.startsWith('-')) {
      return _parseAddRem(s, now, rem: true);
    } else if (s.startsWith('next')) {
      return _parseNextLast(s, now);
    } else if (s.contains('next')) {
      var splitted = s.split('next');
      s = 'next ' + splitted.elementAt(1) + ' at ' + splitted.elementAt(0);
      return _parseNextLast(s, now);
    } else if (s.startsWith('last')) {
      return _parseNextLast(s, now, last: true);
    } else if (s.contains('last')) {
      var splitted = s.split('last');
      s = 'last ' + splitted.elementAt(1) + ' at ' + splitted.elementAt(0);
      return _parseNextLast(s, now, last: true);
    } else if (s.startsWith('yesterday')) {
      return _parseYesterdayTomorrow(s, now);
    } else if (s.startsWith('tomorrow')) {
      return _parseYesterdayTomorrow(s, now, tomorrow: true);
    } else if (s.contains('ago')) {
      return _parseAgo(s, now);
    } else {
      if (REGEX_DATE.hasMatch(s)) {
        return _parseDate(s);
      }
    }
    return DateTime.now();
  }

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
    if (timestamp.toString().length == 13) {
      timestamp = timestamp ~/ 1000;
    }
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
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
      timestamp = timestamp ~/ 1000;
    }
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
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
      String utcTimeString, int timeZoneOffsetHours) {
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
    var now = DateTime.now();
    return date.isAfter(now) ? 1 : (date.isAtSameMomentAs(now) ? 0 : -1);
  }

  static DateTime _parseDate(String s) {
    String date;
    String? setTime;
    if (s.contains('at')) {
      var list = s.split('at');
      date = list.elementAt(0).trim();
      setTime = list.elementAt(1).trim();
    } else {
      date = s.trim();
    }
    var dateSplitted = date.split(' ');
    final month = dateSplitted.elementAt(1);
    var monthAsInt = '';
    if (REGEX_JANUARY.hasMatch(month)) {
      monthAsInt = '0' + DateTime.january.toString();
    } else if (REGEX_FEBRUARY.hasMatch(month)) {
      monthAsInt = '0' + DateTime.february.toString();
    } else if (REGEX_MARCH.hasMatch(month)) {
      monthAsInt = '0' + DateTime.march.toString();
    } else if (REGEX_APRIL.hasMatch(month)) {
      monthAsInt = '0' + DateTime.april.toString();
    } else if (REGEX_MAY.hasMatch(month)) {
      monthAsInt = '0' + DateTime.may.toString();
    } else if (REGEX_JUNE.hasMatch(month)) {
      monthAsInt = '0' + DateTime.june.toString();
    } else if (REGEX_JULY.hasMatch(month)) {
      monthAsInt = '0' + DateTime.july.toString();
    } else if (REGEX_AUGUST.hasMatch(month)) {
      monthAsInt = '0' + DateTime.august.toString();
    } else if (REGEX_SEPTEMBER.hasMatch(month)) {
      monthAsInt = '0' + DateTime.september.toString();
    } else if (REGEX_OCTOBER.hasMatch(month)) {
      monthAsInt = DateTime.october.toString();
    } else if (REGEX_NOVEMBER.hasMatch(month)) {
      monthAsInt = DateTime.november.toString();
    } else if (REGEX_DECEMBER.hasMatch(month)) {
      monthAsInt = DateTime.december.toString();
    }
    var time = DateTime.parse(
        '${dateSplitted.elementAt(2)}-$monthAsInt-${dateSplitted.elementAt(0)} 00:00:00');
    if (setTime != null) {
      time = _parseSetTime(setTime, time);
    }
    return time;
  }

  static DateTime _parseAgo(String s, DateTime now) {
    s = s.substring(0, s.length - 3).trim();
    return _parseAddRem(s, now, rem: true);
  }

  static DateTime _parseYesterdayTomorrow(String s, DateTime now,
      {bool tomorrow = false}) {
    DateTime time;
    if (tomorrow) {
      time = now.add(Duration(days: 1));
    } else {
      time = now.subtract(Duration(days: 1));
    }
    if (s.contains('at')) {
      var list = s.split('at');
      var setTime = list.elementAt(1).trim();
      time = _parseSetTime(setTime, time);
    }
    return time;
  }

  static DateTime _parseAddRem(String s, DateTime now, {bool rem = false}) {
    // Remove the + or -
    if (s.startsWith('+') || s.startsWith('-')) {
      s = s.substring(1);
    }

    String addRem;
    String? setTime;
    if (s.contains('at')) {
      var list = s.split('at');
      addRem = list.elementAt(0).trim();
      setTime = list.elementAt(1).trim();
    } else {
      addRem = s.trim();
    }
    // Split the string
    var list = addRem.split(' ');
    for (var i = 1; i < list.length; i += 2) {
      var value = list.elementAt(i - 1);
      var valueAsInt = int.parse(value);
      if (rem) {
        valueAsInt = valueAsInt * -1;
      }
      var type = list.elementAt(i);
      if (REGEX_YEAR.hasMatch(type)) {
        //print('Add $valueAsInt year(s)');
        now = DateTime(now.year + valueAsInt, now.month, now.day, now.hour,
            now.minute, now.second);
      } else if (REGEX_MONTH.hasMatch(type)) {
        //print('Add $valueAsInt month(s)');
        now = DateTime(now.year, now.month + valueAsInt, now.day, now.hour,
            now.minute, now.second);
      } else if (REGEX_WEEK.hasMatch(type)) {
        // print('Add / Rem $valueAsInt week(s)');
        now = now.add(Duration(days: 7 * valueAsInt));
      } else if (REGEX_DAY.hasMatch(type)) {
        //print('Add $valueAsInt day(s)');
        now = now.add(Duration(days: valueAsInt));
      } else if (REGEX_HOUR.hasMatch(type)) {
        //print('Add $valueAsInt hour(s)');
        now = now.add(Duration(hours: valueAsInt));
      } else if (REGEX_MINUTES.hasMatch(type)) {
        //print('Add $valueAsInt minute(s)');
        now = now.add(Duration(minutes: valueAsInt));
      } else if (REGEX_SECONDS.hasMatch(type)) {
        //print('Add $valueAsInt second(s)');
        now = now.add(Duration(seconds: valueAsInt));
      }
    }
    if (setTime != null) {
      if (setTime.contains(':')) {
        var hhmmss = DateTime.parse('1965-01-01 ' + setTime);
        now = DateTime(now.year, now.month, now.day, hhmmss.hour, hhmmss.minute,
            hhmmss.second);
      } else {
        var list = setTime.split(' ');
        for (var i = 1; i < list.length; i += 2) {
          var value = list.elementAt(i - 1);
          var valueAsInt = int.parse(value);
          if (rem) {
            valueAsInt = valueAsInt * -1;
          }
          var type = list.elementAt(i);
          if (REGEX_HOUR.hasMatch(type)) {
            now = DateTime(now.year, now.month, now.day, valueAsInt, now.minute,
                now.second);
          } else if (REGEX_MINUTES.hasMatch(type)) {
            now = DateTime(
                now.year, now.month, now.day, now.hour, valueAsInt, now.second);
          } else if (REGEX_SECONDS.hasMatch(type)) {
            now = DateTime(
                now.year, now.month, now.day, now.hour, now.minute, valueAsInt);
          }
        }
      }
    }
    return now;
  }

  static DateTime _parseNextLast(String s, DateTime now, {bool last = false}) {
    if (s.startsWith('next') || s.startsWith('last')) {
      s = s.substring(4);
    }
    String lastNext;
    String? setTime;
    if (s.contains('at')) {
      var list = s.split('at');
      lastNext = list.elementAt(0).trim();
      setTime = list.elementAt(1).trim();
    } else {
      lastNext = s.trim();
    }
    if (REGEX_WEEKDAY.hasMatch(lastNext)) {
      var currentDay = now.weekday;
      int daysToAdd;
      late int targetDay;
      if (REGEX_SUNDAY.hasMatch(lastNext)) {
        targetDay = DateTime.sunday;
      } else if (REGEX_SATURDAY.hasMatch(lastNext)) {
        targetDay = DateTime.saturday;
      } else if (REGEX_FRIDAY.hasMatch(lastNext)) {
        targetDay = DateTime.friday;
      } else if (REGEX_THURSDAY.hasMatch(lastNext)) {
        targetDay = DateTime.thursday;
      } else if (REGEX_WEDNESDAY.hasMatch(lastNext)) {
        targetDay = DateTime.wednesday;
      } else if (REGEX_TUESDAY.hasMatch(lastNext)) {
        targetDay = DateTime.tuesday;
      } else if (REGEX_MONDAY.hasMatch(lastNext)) {
        targetDay = DateTime.monday;
      }

      if (last) {
        if (currentDay < targetDay) {
          daysToAdd = daysOfWeek - targetDay + currentDay;
        } else {
          daysToAdd = targetDay - (daysOfWeek - currentDay);
        }
        now = now.add(Duration(days: daysToAdd * -1));
      } else {
        daysToAdd = targetDay - currentDay;
        now = now.add(Duration(days: daysToAdd));
      }
      if (setTime != null) {
        now = _parseSetTime(setTime, now);
      }
      return now;
    }
    if (REGEX_WEEK.hasMatch(lastNext)) {
      if (last) {
        now = now.add(Duration(days: 7 * -1));
      } else {
        now = now.add(Duration(days: 7));
      }
      if (setTime != null) {
        now = _parseSetTime(setTime, now);
      }
      return now;
    }
    return DateTime.now();
  }

  static DateTime _parseSetTime(String setTime, DateTime time) {
    if (setTime.contains(':')) {
      var hhmmss = DateTime.parse('1965-01-01 $setTime');
      return DateTime(time.year, time.month, time.day, hhmmss.hour,
          hhmmss.minute, hhmmss.second);
    } else if (REGEX_AM_PM.hasMatch(setTime)) {
      var baseTime = 0;
      if (setTime.endsWith('pm') || setTime.endsWith('PM')) {
        baseTime = 12;
      }
      setTime = setTime.substring(0, setTime.length - 2).trim();
      setTime = setTime.replaceAll('\.', ':');
      if (setTime.length == 1) {
        setTime = '0$setTime:00:00';
      } else if (setTime.length == 3) {
        setTime = '0$setTime:00';
      } else if (setTime.length == 4) {
        setTime = '$setTime:00:00';
      } else if (setTime.length == 5) {
        setTime = '0$setTime';
      }
      var hhmmss = DateTime.parse('1965-01-01 ' + setTime);
      return DateTime(time.year, time.month, time.day, hhmmss.hour + baseTime,
          hhmmss.minute, hhmmss.second);
    } else {
      var list = setTime.split(' ');
      for (var i = 1; i < list.length; i += 2) {
        var value = list.elementAt(i - 1);
        var valueAsInt = int.parse(value);
        var type = list.elementAt(i);
        if (REGEX_HOUR.hasMatch(type)) {
          time = DateTime(time.year, time.month, time.day, valueAsInt,
              time.minute, time.second);
        } else if (REGEX_MINUTES.hasMatch(type)) {
          time = DateTime(time.year, time.month, time.day, time.hour,
              valueAsInt, time.second);
        } else if (REGEX_SECONDS.hasMatch(type)) {
          time = DateTime(time.year, time.month, time.day, time.hour,
              time.minute, valueAsInt);
        }
      }
      return time;
    }
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
  static String formatDateTimeToString(
      {DateTime? dateTime, String? formatter}) {
    DateTime currentDateTime = dateTime ?? DateTime.now();

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
          formatDateTimeToString(formatter: 'dd MMM yyyy, h:mm a');
      final DateFormat formatter = DateFormat('dd MMM yyyy, h:mm a');
      return formatter.parse(date);
    } catch (e) {
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

    List<String> times = [];

    DateTime currentTime = beginTime;

    while (currentTime.isBefore(endTime)) {
      String formattedTime = DateFormat(
        'hh:mm a',
        locale ?? 'en_US',
      ).format(currentTime);
      times.add(formattedTime);

      currentTime = currentTime.add(Duration(minutes: step));
    }

    String formattedEndTime = DateFormat(
      'hh:mm a',
      locale ?? 'en_US',
    ).format(endTime);
    times.add(formattedEndTime);

    return times;
  }
}
