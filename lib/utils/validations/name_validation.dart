extension VoterIdExtension on String? {
  bool isValidName() {
    return this != null && this!.length >= 6 && cnicnNumberCheck();
  }

  bool cnicnNumberCheck() {
    return this!.codeUnits.every((element) => isNumber(element));
  }

  bool isNumber(int number) {
    return number >= 65 && number <= 122 || number == 32;
  }
}
