class Validator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return '이메일을 입력하세요.';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value!)) {
      return '유효한 이메일 주소를 입력하세요.';
    }
    return null;
  }

  static String? validatePass(String? value) {
    if (value!.isEmpty) {
      return '패스워드를 입력하세요.';
    }
    return null;
  }

  static String? validatePassConfirm(String pass, String? value) {
    if (pass != value) {
      return '비밀번호가 같지 않습니다.';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return '이름을 입력하세요.';
    }
    return null;
  }

  static String? validateNick(String? value) {
    if (value!.isEmpty) {
      return '닉네임을 입력하세요.';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return '핸드폰 번호를 입력하세요.';
    }
    value = value!.replaceAll("-", "");
    if (value.length != 11) {
      return '핸드폰 번호는 11글자여야 합니다.';
    }

    if (!value!.contains(RegExp(r'^[0-9]+$'))) {
      return '숫자만 입력하세요.';
    }
    return null;
  }
}