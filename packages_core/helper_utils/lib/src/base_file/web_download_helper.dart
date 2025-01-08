import 'dart:html' as html;

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

class DownloadHelper {
  factory DownloadHelper() {
    return _instance;
  }

  DownloadHelper._internal();

  static final DownloadHelper _instance = DownloadHelper._internal();

  String getExtension(String url) {
    final ext = url.split('.').last;
    return '.$ext';
  }


  Future<void> downloadImage(String url, String fileName) async {
    var extension = '';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final extensionFile = p.extension(fileName);
      final blob = html.Blob([response.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      if (extensionFile.trim() == '') {
        final mime = lookupMimeType('', headerBytes: response.bodyBytes);
        extension = '.${extensionFromMime(mime!)}';
      }
      html.AnchorElement(href: url)
        ..setAttribute('download', '$fileName$extension')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      throw Exception('Failed to download image');
    }
  }
}
