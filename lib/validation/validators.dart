bool validateEmailAddress(String input){

  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool isValidEmail = emailRegex.hasMatch(input);
  return isValidEmail;
}

bool validatePassword(String password){
  RegExp passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool isValidPassword = passRegex.hasMatch(password);
  return isValidPassword;
}

bool validatePhoneNumber(String number){
  RegExp numRegex = RegExp(r'^(\+8801|8801|01|008801)[1|3-9]{1}(\d){8}$');
  bool isValidNumber = numRegex.hasMatch(number);
  return isValidNumber;
}
