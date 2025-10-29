import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_constants.dart';

/// Helper utilities
class Helpers {
  Helpers._();

  /// Check if running on mobile platform
  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Check if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Check if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Check if running on Web
  static bool get isWeb => kIsWeb;

  /// Check if running on Desktop
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// Check if running on Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Check if running on macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Check if running on Linux
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Format currency
  static String formatCurrency(
      num amount, {
        String symbol = '\$',
        int decimalDigits = 2,
      }) {
    final NumberFormat formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Format number with comma separator
  static String formatNumber(num number) {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  /// Format date to readable string
  static String formatDate(
      DateTime date, {
        String format = AppConstants.dateFormat,
      }) => DateFormat(format).format(date);


  /// Format time to readable string
  static String formatTime(
      DateTime time, {
        String format = AppConstants.timeFormat,
      }) => DateFormat(format).format(time);


  /// Format datetime to readable string
  static String formatDateTime(
      DateTime dateTime, {
        String format = AppConstants.dateTimeFormat,
      }) => DateFormat(format).format(dateTime);


  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 365) {
      final int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  /// Get app version
  static Future<String> getAppVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      return AppConstants.appVersion;
    }
  }

  /// Get app build number
  static Future<String> getBuildNumber() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.buildNumber;
    } catch (e) {
      return '1';
    }
  }

  /// Get full app version with build number
  static Future<String> getFullVersion() async {
    final String version = await getAppVersion();
    final String buildNumber = await getBuildNumber();
    return '$version+$buildNumber';
  }

  /// Delay execution
  static Future<void> delay(Duration duration) => Future.delayed(duration);

  /// Show loading dialog
  static void showLoadingDialog(
      BuildContext context, {
        String? message,
      }) =>
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircularProgressIndicator(),
                if (message != null) ...<Widget>[
                  const SizedBox(height: 16),
                  Text(message),
                ],
              ],
            ),
          ),
        )
    );


  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Show confirmation dialog
  static Future<bool> showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = 'Confirm',
        String cancelText = 'Cancel',
      }) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        )
    );

    return result ?? false;
  }

  /// Generate random color
  static Color generateRandomColor() => Color.fromARGB(
      255,
      DateTime.now().millisecondsSinceEpoch % 256,
      (DateTime.now().millisecondsSinceEpoch ~/ 256) % 256,
      (DateTime.now().millisecondsSinceEpoch ~/ 65536) % 256,
    );


  /// Get initials from name
  static String getInitials(String name) {
    if (name.isEmpty) {
      return '';
    }

    final List<String> names = name.trim().split(' ');
    if (names.length == 1) {
      return names[0][0].toUpperCase();
    }

    return '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();
  }

  /// Validate and format phone number
  static String formatPhoneNumber(String phone) {
    final String digitsOnly = phone.replaceAll(RegExp('[^0-9]'), '');

    if (digitsOnly.length == 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    }

    return phone;
  }

  /// Check if dark mode is enabled
  static bool isDarkMode(BuildContext context)
    => Theme.of(context).brightness == Brightness.dark;


  /// Get contrast color
  static Color getContrastColor(Color color) {
    final double luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Debounce function calls
  static void debounce(Function() action, {
        Duration duration = const Duration(milliseconds: 500),
      }) => Future.delayed(duration, action);

}

