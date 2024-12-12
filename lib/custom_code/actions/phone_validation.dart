Future<bool> vietnamPhoneValidation(String email) async {
  return RegExp(r"(0[3|5|7|8|9])+([0-9]{8})$").hasMatch(email);
}
