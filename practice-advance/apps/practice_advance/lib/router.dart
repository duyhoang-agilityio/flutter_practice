import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/presentation/home_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_package/main.dart';

final GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
