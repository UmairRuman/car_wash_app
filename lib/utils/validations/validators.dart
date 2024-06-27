import 'package:car_wash_app/utils/validations/email_validation.dart';
import 'package:car_wash_app/utils/validations/name_validation.dart';
import 'package:car_wash_app/utils/validations/password_validation.dart';

String? emailValidator(String? elment) {
  if (elment.isValidEmail()) {
    return null;
  } else {
    return "Enter the Valid Email";
  }
}

String? nameValidator(String? elment) {
  if (elment.isValidName()) {
    return null;
  } else {
    return "Name must only at least 6 letters";
  }
}

String? passwordValidator(String? elment) {
  if (elment.isValidPassword()) {
    return null;
  } else {
    return "Password must contain 8 strong letters";
  }
}
