import 'dart:io';

import 'package:flutter/services.dart';

class FileEntity extends _BaseFile {
  FileEntity({
    this.fileName,
    this.fileSize,
    this.mimeType,
    this.url,
    this.uid,
  });

  FileEntity.fromJson(dynamic json) {
    fileName = json['fileName'];
    fileSize = json['fileSize'];
    mimeType = json['mimeType'];
    url = json['url'];
  }

  String? uid;
  String? fileName;
  int? fileSize;
  String? mimeType;
  String? url;

  FileEntity copyWith({
    String? fileName,
    int? fileSize,
    String? mimeType,
    String? url,
  }) =>
      FileEntity(
        fileName: fileName ?? this.fileName,
        fileSize: fileSize ?? this.fileSize,
        mimeType: mimeType ?? this.mimeType,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = fileName;
    map['fileSize'] = fileSize;
    map['mimeType'] = mimeType;
    map['url'] = url;
    map['uid'] = uid;
    return map;
  }
}

class _BaseFile {
  File? file;
  Uint8List? bytes;
  String? binary;
  String? originalFilename;
  String? thumbUrl;
}
