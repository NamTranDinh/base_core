class AppValidator {
  AppValidator._();

  static bool isDateValid({required String inputDate}) {
    final RegExp datePattern = RegExp(r'^(\d{1,2})[-/](\d{1,2})[-/](\d{4})$');
    final Match? match = datePattern.firstMatch(inputDate);

    if (match == null) {
      return false; // Date format doesn't match
    }

    int day = int.parse(match.group(1)!);
    int month = int.parse(match.group(2)!);
    int year = int.parse(match.group(3)!);

    // ... rest of the validation logic ...

    // Call your existing validation function
    if (year < 1 ||
        year > 9999 ||
        month < 1 ||
        month > 12 ||
        day < 1 ||
        day > 31) {
      return false;
    }

    if (month == 4 || month == 6 || month == 9 || month == 11) {
      return day <= 30;
    } else if (month == 2) {
      if (year % 4 == 0) {
        if (year % 100 != 0 || year % 400 == 0) {
          return day <= 29;
        }
      }
      return day <= 28;
    }

    return true;
  }

  static bool isValidURL(String url) {
    final urlPattern = r'(http|https):\/\/([\w-]+(\.[\w-]+)+)([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  static bool validateYear(int year) {
    int currentYear = DateTime.now().year;
    return year < currentYear;
  }
}
