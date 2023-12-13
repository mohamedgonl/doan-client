class ValidateUtils {
  static bool validatePhoneNumberOrEmail(String phoneOrEmail) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(phoneOrEmail) ||
        RegExp(r"^(?:[+0]9)?[0-9]{10,15}$").hasMatch(phoneOrEmail)) {
      return true;
    }
    return false;
  }

  static bool validatePhoneNumber(String phoneNumber) {
    if (RegExp(r"^(?:[+0]9)?[0-9]{10,15}$").hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  static bool validatePhoneNumberSerivce(String phoneNumber) {
    if (RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  static bool validateEmail(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    }
    return false;
  }
}
