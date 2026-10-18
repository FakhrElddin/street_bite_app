import 'package:street_bite_app/generated/l10n.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.trim().isEmpty) {
      return S.current.fieldRequired;
    } else if (emailRegex.hasMatch(val) == false) {
      return S.current.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])');
    if (val == null || val.isEmpty) {
      return S.current.fieldRequired;
    } else if (val.length < 8 || !passwordRegex.hasMatch(val)) {
      return S.current.enterStrongPassword;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return S.current.fieldRequired;
    } else if (confirmPassword != password) {
      return S.current.enterSamePassword;
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    RegExp usernameRegex = RegExp(r'^[A-Z][a-zA-Z0-9,.-]*$');
    if (val == null || val.isEmpty) {
      return S.current.fieldRequired;
    } else if (!usernameRegex.hasMatch(val)) {
      return S.current.enterValidUsername;
    } else {
      return null;
    }
  }

  static String? validate(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.fieldRequired;
    } else {
      return null;
    }
  }

  static String? validatePinCode(String? val, int codeLength) {
    if (val == null || val.isEmpty) {
      return S.current.fieldRequired;
    } else if (val.length != codeLength) {
      return S.current.completeCode;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return S.current.fieldRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return S.current.enterNumbersOnly;
    } else if (val.trim().length != 11) {
      return S.current.phoneNumberLengthError;
    } else {
      return null;
    }
  }
}
