bool isValidEmail(String email) {
  // Regular expression for basic email validation
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    caseSensitive: false,
  );

  // Check if the email matches the pattern and has a reasonable length
  return emailRegExp.hasMatch(email) &&
      email.length >= 5 &&
      email.length <= 254;
}

bool isValidPhoneNumber(String phone) {
  // Remove all non-digit characters
  final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');

  // Check if it has at least 10 digits
  return digitsOnly.length >= 10 && digitsOnly.length <= 15;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else {
    // Check for minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters ';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
