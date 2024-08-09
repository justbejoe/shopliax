import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shopliax_todo/Config/routes/app_routes.dart';
import 'package:shopliax_todo/Config/routes/route_location.dart';

final navigationKey = GlobalKey<NavigatorState>();

final routesProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteLocation.landingPage,
      navigatorKey: navigationKey,
      routes: appRoutes,
    );
  },
);
