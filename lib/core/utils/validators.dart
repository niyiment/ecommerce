import '../constants/app_constants.dart';

class Validators {
  Validators._();

  /// Validate email address
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!AppConstants.emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validate phone number
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!AppConstants.phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validate password
  static String? validatePassword(String? password, {int minLength = 8}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < minLength) {
      return 'Password must be at least 8 characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validate confirm password
  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(
    String? value,
    int minLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(
    String? value,
    int maxLength, {
    String fieldName = 'Field',
  }) {
    if (value != null && value.length > maxLength) {
      return '$fieldName cannot exceed $maxLength characters';
    }

    return null;
  }

  /// Validate numeric value
  static String? validateNumeric(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Validate range
  static String? validateRange(
    String? value,
    int min,
    int max, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final num? numValue = num.tryParse(value);
    if (numValue == null) {
      return '$fieldName must be a valid number';
    }
    if (numValue < min || numValue > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  /// Validate URL
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    final Uri? uri = Uri.tryParse(value);
    if (uri == null || uri.hasScheme) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validate date
  static String? validateDate(String? value, {String format = 'dd/MM/yyyy'}) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    try {
      final List<String> parts = value.split('/');
      if (parts.length != 3) {
        return 'Please enter a valid date in the format $format';
      }
      final int day = int.parse(parts[0]);
      final int month = int.parse(parts[1]);
      final int year = int.parse(parts[2]);

      final DateTime date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        return 'Please enter a valid date';
      }

      return null;
    } catch (e) {
      return 'Please enter a valid date in the format $format';
    }
  }

  /// Combine multiple validators
  static String? combineValidators(
    List<String? Function()> validators,
  ) {
    for (final String? Function() validator in validators) {
      final String? error = validator();
      if (error != null) {
        return error;
      }
    }

    return null;
  }
}
