extension StringExtension on String? {
  bool isValidEmail() {
    if (this == null) return false; // Check for null before anything else

    // Trim leading and trailing spaces from the email string
    final trimmedString = this!.trim();

    // Regular expression to validate an email address format
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Check if the trimmed string matches the regex pattern
    return emailRegex.hasMatch(trimmedString);
  }

  String? trimEmail() {
    return this?.trim();
  }
}
