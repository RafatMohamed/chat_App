import '../resources/app_texts.dart';

class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null) {
      return AppTexts.fieldRequired;
    } else if (val.trim().isEmpty) {
      return AppTexts.fieldRequired;
    } else if (emailRegex.hasMatch(val) == false) {
      return AppTexts.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    if (val == null) {
      return AppTexts.fieldRequired;
    } else if (val.isEmpty) {
      return AppTexts.fieldRequired;
    } else if (val.length < 8) {
      return AppTexts.strongPasswordPlease;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return AppTexts.fieldRequired;
    } else if (val != password) {
      return AppTexts.samePassword;
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null) {
      return AppTexts.fieldRequired;
    } else if (val.isEmpty) {
      return AppTexts.fieldRequired;
    } else if (!usernameRegex.hasMatch(val)) {
      return AppTexts.enterValidUsername;
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return AppTexts.fieldRequired;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return AppTexts.fieldRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return AppTexts.enterNumbersOnly;
    } else if (val.trim().length != 11) {
      return AppTexts.enterValueMustEqual11Digit;
    } else {
      return null;
    }
  }
}
