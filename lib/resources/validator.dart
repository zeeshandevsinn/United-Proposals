class FieldValidator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email address";
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value.trim())) {
      return "Enter valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password limit";
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return "Password should include 1 number";
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return "Password should 1 special character";
    }
    return null;
  }

  static String? validateOldPassword(String? value) {
    if (value!.isEmpty) {
      return "Old password required";
    }
    if (value.length < 6) {
      return "Old password consists minimum 6 character";
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return "Old password should include 1 number";
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return "Old password should include 1 special char";
    }
    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (pass2!.isEmpty) {
      return "Please re enter your password";
    }
    if (value != pass2) {
      return "Password does not match";
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) return "Enter OTP";
    if (value.length < 6) {
      return "Please enter the OTP";
    }
    Pattern pattern = r'^[0-9]{6}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return "Invalid OTP";
    }
    return null;
  }
}
