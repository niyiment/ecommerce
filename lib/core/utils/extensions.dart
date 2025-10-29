import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Context extensions for easy access to common properties
extension ContextExtensions on BuildContext {
  /// Get MediaQuery data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Check if device is mobile
  bool get isMobile => screenWidth < AppConstants.mobileBreakpoint;

  /// Check if device is tablet
  bool get isTablet =>
      screenWidth >= AppConstants.mobileBreakpoint &&
          screenWidth < AppConstants.desktopBreakpoint;

  /// Check if device is desktop
  bool get isDesktop => screenWidth >= AppConstants.desktopBreakpoint;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Show snackbar
  void showSnackBar(
      String message, {
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Unfocus keyboard
  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  /// Request focus
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }
}

/// String extensions
extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((String word) => word.capitalize).join(' ');
  }

  /// Check if string is valid email
  bool get isValidEmail => AppConstants.emailRegex.hasMatch(this);

  /// Check if string is valid phone
  bool get isValidPhone => AppConstants.phoneRegex.hasMatch(this);

  /// Remove whitespace
  String get removeWhitespace => replaceAll(' ', '');

  /// Check if string is empty or whitespace
  bool get isEmptyOrWhitespace => trim().isEmpty;

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Parse to DateTime
  DateTime? toDateTime([String format = AppConstants.dateFormat]) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  /// Parse to int
  int? toIntOrNull() => int.tryParse(this);

  /// Parse to double
  double? toDoubleOrNull() => double.tryParse(this);
}

/// DateTime extensions
extension DateTimeExtensions on DateTime {
  /// Format to string
  String format([String pattern = AppConstants.dateFormat]) {
    return DateFormat(pattern).format(this);
  }

  /// Check if date is today
  bool get isToday {
    final DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get time ago string
  String get timeAgo {
    final Duration difference = DateTime.now().difference(this);

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

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());
}

/// List extensions
extension ListExtensions<T> on List<T> {
  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  /// Check if list is not empty
  bool get isNotEmpty => !isEmpty;

  /// Safely get element at index
  T? elementAtOrNull(int index) {
    if (index >= 0 && index < length) {
      return elementAt(index);
    }
    return null;
  }
}

/// Widget extensions
extension WidgetExtensions on Widget {
  /// Add padding
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  /// Add symmetric padding
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
     Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );


  /// Add custom padding
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );


  /// Add centered widget
  Widget centered() => Center(child: this);

  /// Add expanded widget
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Add flexible widget
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose})
    => Flexible(flex: flex, fit: fit, child: this);

  /// Add gesture detector
  Widget onTap(VoidCallback onTap) =>  GestureDetector(
      onTap: onTap,
      child: this,
    );


  /// Add ink well
  Widget inkWell({
    required VoidCallback onTap,
    BorderRadius? borderRadius,
  }) => InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: this,
    );


  /// Add visibility
  Widget visible(bool visible) =>
     Visibility(
      visible: visible,
      child: this,
    );


  /// Add opacity
  Widget opacity(double opacity) => Opacity(
      opacity: opacity,
      child: this,
    );

}
