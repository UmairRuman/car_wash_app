extension VoterIdExtension on String? {
  bool isValidPassword() {
    return this != null && this!.length >= 8 && cnicnNumberCheck();
  }

  bool cnicnNumberCheck() {
    return this!.codeUnits.every((element) => isNumber(element));
  }

  bool isNumber(int number) {
    return number >= 65 && number <= 122 || number >= 48 && number <= 57;
  }
}
