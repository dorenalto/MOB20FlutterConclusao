class CustomValidators {
  static String isEmail(String email) {
    RegExp regex = RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");

    if (email.isEmpty) {
      return 'O e-mail não pode ser vazio';
    }

    if (!regex.hasMatch(email)) {
      return 'E-mail inválido';
    }

    return null;
  }
}
