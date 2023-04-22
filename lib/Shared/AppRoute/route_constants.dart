// ignore_for_file: camel_case_types

enum APP_PAGE {
  initial,
  home,
  results,
  onboarding,
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.initial:
        return '/';
      case APP_PAGE.home:
        return 'home';
      case APP_PAGE.results:
        return 'results';
      case APP_PAGE.onboarding:
        return 'onboarding';
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.initial:
        return 'initial';
      case APP_PAGE.home:
        return 'home';
      case APP_PAGE.results:
        return 'results';
      case APP_PAGE.onboarding:
        return 'onboarding';
    }
  }
}
