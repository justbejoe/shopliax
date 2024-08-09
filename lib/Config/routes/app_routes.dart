import 'package:go_router/go_router.dart';
import 'package:shopliax_todo/Config/routes/route_location.dart';
import 'package:shopliax_todo/UI/create_todo.dart';
import 'package:shopliax_todo/UI/home.dart';
import 'package:shopliax_todo/UI/landing_page.dart';
import 'package:shopliax_todo/UI/photo_screen.dart';
import 'package:shopliax_todo/config/routes/route_provider.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: Home.builder,
  ),
  GoRoute(
    path: RouteLocation.createTodo,
    parentNavigatorKey: navigationKey,
    builder: CreateTodoScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.photoScreen,
    parentNavigatorKey: navigationKey,
    builder: PhotoScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.landingPage,
    parentNavigatorKey: navigationKey,
    builder: LandingPage.builder,
  ),
];
