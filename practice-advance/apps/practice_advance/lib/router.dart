import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/core/router/page_names.dart';
import 'package:practice_advance/features/home/presentation/home_screen.dart';
import 'package:practice_advance_design/foundations/models.dart';
import 'package:practice_advance_design/molecules/main_navigator.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_package/main.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellBottomNavLayoutNavigatorKey = GlobalKey<NavigatorState>();

class AppRouteNames {
  static AgbUiRoute splash = AgbUiRoute(
    '/splash',
    AgbPageNames.splash,
  );
  static AgbUiRoute welcome = AgbUiRoute(
    '/welcome',
    AgbPageNames.welcome,
  );

  // Home route
  static AgbUiRoute home = AgbUiRoute('/home', AgbPageNames.home);
  static AgbUiRoute category = AgbUiRoute('/category', AgbPageNames.category);
  static AgbUiRoute cart = AgbUiRoute('/cart', AgbPageNames.cart);
  static AgbUiRoute profile = AgbUiRoute('/profile', AgbPageNames.profile);
}

final GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellBottomNavLayoutNavigatorKey,
      builder: (context, state, child) {
        return AgbUiScaffold(
          mainNavigation: AgbUiMainNavigation(
            items: _navigationItems(context),
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellBottomNavLayoutNavigatorKey,
          path: AppRouteNames.home.path,
          name: AppRouteNames.home.name,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(
            child: HomePage(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellBottomNavLayoutNavigatorKey,
          path: AppRouteNames.category.path,
          name: AppRouteNames.category.name,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(
            // child: CategoryPage(),
            child: HomePage(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellBottomNavLayoutNavigatorKey,
          path: AppRouteNames.cart.path,
          name: AppRouteNames.cart.name,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(
            // child: CartPage(),
            child: HomePage(),
          ),
        ),
        GoRoute(
          parentNavigatorKey: _shellBottomNavLayoutNavigatorKey,
          path: AppRouteNames.profile.path,
          name: AppRouteNames.profile.name,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<void>(
            // child: ProfilePage(),
            child: HomePage(),
          ),
        ),
      ],
    ),
  ],
);

List<AgbUiBottomNavBarModel> _navigationItems(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  final intl = AppLocalizations.of(context)!;

  return <AgbUiBottomNavBarModel>[
    AgbUiBottomNavBarModel(
      label: intl.txtHome,
      icon: BazarIcon.ichome(),
      activeIcon: BazarIcon.ichome(color: theme.primary),
      routeNamed: AppRouteNames.home,
    ),
    AgbUiBottomNavBarModel(
      label: intl.txtCategory,
      icon: BazarIcon.icCategory(),
      activeIcon: BazarIcon.icCategory(color: theme.primary),
      routeNamed: AppRouteNames.category,
    ),
    AgbUiBottomNavBarModel(
      label: intl.txtCart,
      icon: BazarIcon.icCart(),
      activeIcon: BazarIcon.icCart(color: theme.primary),
      routeNamed: AppRouteNames.cart,
    ),
    AgbUiBottomNavBarModel(
      label: intl.txtProfile,
      icon: BazarIcon.icProfile(),
      activeIcon: BazarIcon.icProfile(color: theme.primary),
      routeNamed: AppRouteNames.profile,
    ),
  ];
}
