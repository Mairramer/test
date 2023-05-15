/// Interface for the app strings.
abstract class AppStrings {
  /// The hello string
  String get hello;

  /// The title of the home screen
  String get titleHomeScreen;
}

/// The implementation of the app strings.
class AppStringsImpl implements AppStrings {
  @override
  String get hello => 'Hello';

  @override
  String get titleHomeScreen => 'Home Screen';
}
