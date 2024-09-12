extension VoterIdExtension on String? {
  bool isValidName() {
    // Check if the input is null, has a minimum length of 6, and passes the alphanumeric check.
    return this != null && this!.trim().length >= 6 && alphanumericCheck();
  }

  bool alphanumericCheck() {
    final trimmedString = this!.trim(); // Trim leading and trailing spaces
    // Check if every character in the string is a letter, number, or space
    return trimmedString.codeUnits.every((element) => isAlphanumeric(element));
  }

  bool isAlphanumeric(int codeUnit) {
    // Check if the code unit is a letter (A-Z, a-z), digit (0-9), or a space
    return (codeUnit >= 65 && codeUnit <= 90) || // A-Z
        (codeUnit >= 97 && codeUnit <= 122) || // a-z
        (codeUnit >= 48 && codeUnit <= 57) || // 0-9
        codeUnit == 32; // Space
  }
}
