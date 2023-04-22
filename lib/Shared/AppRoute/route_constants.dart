// ignore_for_file: camel_case_types

enum APP_PAGE {
  initial,
  home,
  login,
  register,
  resetPassword,
  results,
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.initial:
        return '/';
      case APP_PAGE.home:
        return '/home';
      case APP_PAGE.login:
        return 'login';
      case APP_PAGE.register:
        return 'register';
      case APP_PAGE.resetPassword:
        return 'reset_password';
      case APP_PAGE.results:
        return 'results';
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.initial:
        return 'initial';
      case APP_PAGE.register:
        return 'register';
      case APP_PAGE.login:
        return 'login';
      case APP_PAGE.home:
        return 'home';
      case APP_PAGE.resetPassword:
        return 'reset_password';
      case APP_PAGE.results:
        return 'results';
    }
  }
}
