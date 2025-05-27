import 'dart:io';

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

  String get name => path.split('/').last;
}
