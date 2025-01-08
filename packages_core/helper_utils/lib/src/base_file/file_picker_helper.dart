import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:helper_utils/src/base_file/file_entity.dart';
import 'package:mime/mime.dart';

class FilePickerHelper {
  static Future<FileEntity?> selectSingleFile({
    Function(FilePickerStatus status)? onFileLoading,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      onFileLoading: onFileLoading,
      allowedExtensions: allowedExtensions,
      type: FileType.custom,
    );
    if (result != null) {
      final file = result.files.first;
      return _mapFileToModel(file);
    }
    return null;
  }

  static Future<List<FileEntity>> selectMultipleFile({
    Function(FilePickerStatus status)? onFileLoading,
    List<String>? allowedExtensions,
  }) async {
    final files = <FileEntity>[];
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      onFileLoading: onFileLoading,
    );
    if (result != null) {
      for (final f in result.files) {
        final fileEntity = await _mapFileToModel(f);
        files.add(fileEntity);
      }
    } else {}
    return files;
  }

  static Future<FileEntity> _mapFileToModel(PlatformFile file) async {
    final entity = FileEntity()
      ..fileSize = file.size
      ..fileName = file.name
      ..bytes = file.bytes
      ..mimeType = lookupMimeType(file.name);
    if (!kIsWeb) {
      entity.url = file.path;
    }

    if (file.bytes != null) {
      final bytes = file.bytes!;
      final binary = base64.encode(bytes);
      entity.binary = binary;
    }
    return entity;
  }

  static Future<String> fileToBinary(File file) async {
    final List<int> fileBytes = await file.readAsBytes();
    return fileBytes
        .map((byte) => byte.toRadixString(2).padLeft(8, '0'))
        .join();
  }
}
