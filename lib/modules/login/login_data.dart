import 'package:email_validator/email_validator.dart';

class LogInData {
  String? _email;
  String? _password;

  setEmailValue(e) {
    _email = e;
  }

  setPasswordValue(e) {
    _password = e;
  }

  getEmail() {
    return _email;
  }

  getPassword() {
    return _password;
  }

  getAllData() {
    return "$_email$_password";
  }

  isValid() {
    return EmailValidator.validate(getEmail());
  }
}
