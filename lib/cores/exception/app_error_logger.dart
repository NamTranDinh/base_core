import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

typedef DirectoryProvider = Future<Directory> Function();

class AppErrorLogger {
  AppErrorLogger._();

  static final AppErrorLogger _instance = AppErrorLogger._();

  static AppErrorLogger get instance => _instance;

  late File _logFile;
  bool _isInitialized = false;
  DirectoryProvider? _logDirectoryProvider;

  /// Call in `main()` to initialize the logger
  Future<void> initialize() async {
    try {
      await initializeDateFormatting();

      _logDirectoryProvider = () async {
        final dir = await getApplicationDocumentsDirectory();
        return Directory('${dir.path}/logs');
      };

      final logDir = await _logDirectoryProvider!();

      if (!logDir.existsSync()) {
        await logDir.create(recursive: true);
      }

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _logFile = File('${logDir.path}/error_log_$today.txt');

      if (!_logFile.existsSync()) {
        await _logFile.create();
        await _writeHeader();
      }

      _isInitialized = true;
      debugPrint('[✅ Error Logger initialized]: ${_logFile.path}');
    } on Exception catch (e) {
      debugPrint('[❌ Failed to initialize Error Logger]: $e');
    }
  }

  Future<void> _writeHeader() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final header = '''
===============================================
Flutter App Error Log
Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}
App Version: ${packageInfo.version} (Build ${packageInfo.buildNumber})
Platform: ${Platform.operatingSystem}
===============================================
    ''';
    await _logFile.writeAsString(header, mode: FileMode.append);
  }

  Future<void> logError({
    required String source,
    required Object error,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalInfo,
    Function(Object error, StackTrace? stackTrace)? onReleaseErrorCallback,
  }) async {
    if (!_isInitialized) {
      debugPrint('[⚠️ Error Logger not initialized]');
      return;
    }

    if (kDebugMode) {
      // DEBUG MODE: write to file
      try {
        final timestamp = DateFormat(
          'yyyy-MM-dd HH:mm:ss',
          Platform.localeName,
        ).format(DateTime.now());

        final logEntry = {
          'timestamp': timestamp,
          'Locale': Platform.localeName,
          'source': source,
          'error_type': error.runtimeType.toString(),
          'error_message': error.toString(),
          'stack_trace': stackTrace?.toString(),
          'additional_info': additionalInfo,
          'platform': Platform.operatingSystem,
          'debug_mode': kDebugMode,
        };

        final formattedLog = _formatLogEntry(logEntry);

        await _logFile.writeAsString(formattedLog, mode: FileMode.append);
        debugPrint('[📝 Error logged to file]: ${_logFile.path}');
      } on Exception catch (e) {
        debugPrint('[❌ Failed to write error log]: $e');
      }
    } else {
      // RELEASE MODE: call callback if available
      if (onReleaseErrorCallback != null) {
        try {
          onReleaseErrorCallback(error, stackTrace);
        } on Exception catch (callbackError) {
          // Avoid crash if callback fails
          debugPrint('[❌ Error in onReleaseErrorCallback]: $callbackError');
        }
      }
    }
  }

  String _formatLogEntry(Map<String, dynamic> entry) {
    final buffer = StringBuffer()
      ..writeln()
      ..writeln('═' * 60)
      ..writeln('🔴 ERROR LOG ENTRY')
      ..writeln('═' * 60)
      ..writeln(
        '📅 Timestamp: ${entry['timestamp']} (Locale: ${entry['Locale']})',
      )
      ..writeln('🌍 Time Zone: UTC${DateTime.now().timeZoneOffset}')
      ..writeln('📌 Source: ${entry['source']}')
      ..writeln('⚠️ Error Type: ${entry['error_type']}')
      ..writeln(
        '🖥️ Platform: ${entry['platform']} (Debug: ${entry['debug_mode']})',
      )
      ..writeln()
      ..writeln('📋 Error Message:')
      ..writeln(entry['error_message'])
      ..writeln();

    if (entry['additional_info'] != null) {
      buffer.writeln('ℹ️ Additional Info:');
      (entry['additional_info'] as Map<String, dynamic>).forEach((key, value) {
        buffer.writeln('  🔹 $key: $value');
      });
      buffer.writeln();
    }

    if (entry['stack_trace'] != null) {
      buffer
        ..writeln('📚 Stack Trace:')
        ..writeln(entry['stack_trace']);
    }

    buffer.writeln('═' * 60);
    return buffer.toString();
  }

  String? get logFilePath => _isInitialized ? _logFile.path : null;

  Future<String> readLogs() async {
    if (!_isInitialized || !_logFile.existsSync()) {
      return 'No logs available';
    }

    try {
      return await _logFile.readAsString();
    } on Exception catch (e) {
      return 'Error reading logs: $e';
    }
  }

  Future<void> clearLogs() async {
    if (!_isInitialized) {
      return;
    }

    try {
      await _logFile.writeAsString('');
      await _writeHeader();
      debugPrint('[🗑️ Logs cleared]');
    } on Exception catch (e) {
      debugPrint('[❌ Failed to clear logs]: $e');
    }
  }

  Future<List<File>> getAllLogFiles() async {
    try {
      if (_logDirectoryProvider == null) {
        return [];
      }

      final logDir = await _logDirectoryProvider!();

      if (!logDir.existsSync()) {
        return [];
      }

      final files = await logDir.list().toList();
      return files
          .whereType<File>()
          .where((f) => f.path.endsWith('.txt'))
          .toList();
    } on Exception catch (e) {
      debugPrint('[❌ Failed to get log files]: $e');
      return [];
    }
  }

  Future<void> cleanupOldLogs({int keepDays = 7}) async {
    try {
      final allFiles = await getAllLogFiles();
      final cutoffDate = DateTime.now().subtract(Duration(days: keepDays));

      for (final file in allFiles) {
        final stat = file.statSync();
        if (stat.modified.isBefore(cutoffDate)) {
          await file.delete();
          debugPrint('[🗑️ Deleted old log file]: ${file.path}');
        }
      }
    } on Exception catch (e) {
      debugPrint('[❌ Failed to cleanup old logs]: $e');
    }
  }
}
