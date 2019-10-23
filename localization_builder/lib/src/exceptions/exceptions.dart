class AppLocalizationsGeneratorException implements Exception {
  final String cause;

  AppLocalizationsGeneratorException(this.cause);

  @override
  String toString() {
    return 'AppLocalizationsGeneratorException: $cause';
  }
}