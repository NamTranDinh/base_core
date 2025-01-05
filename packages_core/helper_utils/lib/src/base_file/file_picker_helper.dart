import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:helper_utils/src/base_file/file_entity.dart';
import 'package:mime/mime.dart';

class FilePickerHelper {
  static Future<FileEntity?> selectSingleFile({
    Function(FilePickerStatus status)? onFileLoading,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
    final List<FileEntity> files = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
    final FileEntity entity = FileEntity()
      // ..url = file.path // path is not support on web
      ..fileSize = file.size
      ..fileName = file.name
      ..bytes = file.bytes
      ..mimeType = lookupMimeType(file.name);
    if (file.bytes != null) {
      Uint8List bytes = file.bytes!;
      String binary = base64.encode(bytes);
      entity.binary = binary;
    }
    return entity;
  }

  static Future<String> fileToBinary(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    String binaryData = fileBytes.map(
      (byte) {
        return byte.toRadixString(2).padLeft(8, '0');
      },
    ).join('');
    return binaryData;
  }
}
