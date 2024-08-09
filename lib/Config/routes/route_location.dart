import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();

  static String get home => '/home';
  static String get createTodo => '/createTodo';
  static String get photoScreen => '/photoScreen';
  static String get landingPage => '/landingPage';
}
