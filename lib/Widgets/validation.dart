class validation {
  static String? nameValidator({required String? name}) {
    if (name!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  static String? lastNameValidator({required String? lastName}) {
    if (lastName!.isEmpty) {
      return 'Last Name is required';
    }
    if (lastName.length > 12) {
      return 'Last Name must be at least 12 characters long';
    }
    return null;
  }
  static String? usernameValidator({required String? username}) {
    if (username!.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 6) {
      return 'Username must be at least 6 characters long';
    }
    return null;
  }
  static String? validateEmail({required String? email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (email!.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validatePassword({required String? value}) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
