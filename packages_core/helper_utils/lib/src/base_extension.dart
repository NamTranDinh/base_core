import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

extension ContextExtension on BuildContext {
  Brightness get brightness => MediaQuery.of(this).platformBrightness;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;

  TextScaler get textScaleFactor => MediaQuery.of(this).textScaler;

  double get heightDevice => mediaQuery.size.height;

  double get widthDevice => mediaQuery.size.width;

  double dynamicWidth({required double val}) => widthDevice * val;

  double dynamicHeight({required double val}) => heightDevice * val;
}

extension AppLocalizationsExtension on BuildContext {
  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }
}

extension StringExtension on String {
  String get toFirstCapital {
    return this.split(' ').map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
      }
      return word;
    }).join(' ');
  }

  String get removeDiacritics {
    return replaceAll(RegExp(r'[^\x00-\x7F]'), '').toLowerCase();
  }
}

extension ListExtension<T> on List {
  bool hasObjectInList(T object, bool Function(T, T) condition) {
    return any((item) => condition(item, object));
  }

  void toggleAll<T>(List<T> list) {
    if (length == list.length) {
      clear();
    } else {
      clear();
      addAll(list);
    }
  }
}

extension SetExtension on Set<dynamic> {
  void toggle(String val) {
    if (!contains(val)) {
      add(val);
    } else {
      remove(val);
    }
  }

  void toggleAll(List<String> list) {
    if (length == list.length) {
      clear();
    } else {
      addAll(list);
    }
  }
}

extension MapExtension on Map<dynamic, dynamic> {
  String get format {
    if (isEmpty) {
      return '';
    } else {
      final firstKey = entries.first.key;
      final mapValues = entries.first.value;
      return '?$firstKey=$mapValues';
    }
  }
}

extension IntegetExtension on int? {
  bool get success {
    if (this == 200 || this == 201 || this == 202 || this == 204) {
      return true;
    }
    return false;
  }
}

extension FileExtention on File {
  int get size {
    final sizeInBytes = lengthSync();
    return sizeInBytes;
  }

  String get name {
    return path.basename(this.path);
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapWithIndex<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

extension IndexedMap<K, V> on Map<K, V> {
  Iterable<T> mapWithIndex<T>(T Function(int i, K key, V value) f) {
    var i = 0;
    return entries.map((entry) => f(i++, entry.key, entry.value));
  }
}

extension CubitExt<T> on Cubit<T> {
  void safeEmit(T state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      emit(state);
    }
  }
}
