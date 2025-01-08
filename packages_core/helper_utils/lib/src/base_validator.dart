class AppValidator {
  AppValidator._();

  /// Example:
  /// ```dart
  /// bool isValid = isValidDate('12-01-2025'); // true
  /// bool isInvalid = isValidDate('32-01-2025'); // false
  /// ```
  static bool isValidDate(String value) {
    final regularExpression = RegExp(
      r'^(3[01]|[12][0-9]|0[1-9])-(1[0-2]|0[1-9])-[0-9]{4}$',
    );
    return regularExpression.hasMatch(value);
  }

  /// Example:
  /// ```dart
  /// bool isEmailValid = isValidEmail('example@domain.com'); // true
  /// bool isEmailInvalid = isValidEmail('invalid-email'); // false
  /// ```
  static bool isValidEmail(String value) {
    final regularExpression = RegExp(r'^[A-Za-z0-9+_.-]+@(.+)$');
    return regularExpression.hasMatch(value);
  }

  /// Example:
  /// ```dart
  /// bool isUrlValid = isValidURL('https://www.example.com'); // true
  /// bool isUrlInvalid = isValidURL('invalid-url'); // false
  /// ```
  static bool isValidURL(String url) {
    final result = RegExp(
      r'(http|https):\/\/([\w-]+(\.[\w-]+)+)([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?',
    ).hasMatch(url);
    return result;
  }

  /// Example:
  /// ```dart
  /// bool isPhoneValid = isValidPhoneNumber('+1234567890'); // true
  /// bool isPhoneInvalid = isValidPhoneNumber('123-456-7890'); // false
  /// ```
  static bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phoneNumber);
  }
}
