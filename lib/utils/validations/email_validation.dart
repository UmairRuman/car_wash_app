extension StringExtension on String? {
  bool isValidEmail() {
    if (this == null) return false;

    final trimmedString = this!.trim(); // Trim leading and trailing spaces

    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(trimmedString);
  }
}
