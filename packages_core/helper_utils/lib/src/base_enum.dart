import 'package:path/path.dart' as path;

enum EnumTypeFile {
  isVideo,
  isImage,
  isAudio,
  isPdf,
  isPpt,
  isDoc,
  isExcel,
  isUnknown;

  static EnumTypeFile checkTypeFile(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    if (extension == '.jpg' ||
        extension == '.jpeg' ||
        extension == '.png' ||
        extension == '.gif' ||
        extension == '.webp') {
      return EnumTypeFile.isImage;
    } else if (extension == '.mp4' ||
        extension == '.avi' ||
        extension == '.mov' ||
        extension == '.wmv' ||
        extension == '.flv' ||
        extension == '.mkv') {
      return EnumTypeFile.isVideo;
    } else if (extension == '.doc' ||
        extension == '.docx' ||
        extension == '.odt' ||
        extension == '.rtf') {
      return EnumTypeFile.isDoc;
    } else if (extension == '.pdf') {
      return EnumTypeFile.isPdf;
    } else if (extension == '.ppt' || extension == '.pptx') {
      return EnumTypeFile.isPpt;
    } else if (extension == '.xls' ||
        extension == '.xlsx' ||
        extension == '.ods' ||
        extension == '.csv') {
      return EnumTypeFile.isExcel;
    } else if (extension == '.mp3') {
      return EnumTypeFile.isAudio;
    } else {
      return EnumTypeFile.isUnknown;
    }
  }
}

enum EnumDataSourceType { asset, network, file, contentUri, base64, unknown }

enum EnumNetworkSpeedType { veryFast, fast, slow }
