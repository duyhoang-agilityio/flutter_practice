import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/core/router/page_names.dart';
import 'package:practice_advance/features/cart/presentation/cart_screen.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance/features/home/presentation/home_screen.dart';
import 'package:practice_advance/features/home_author/presentation/author_detail.dart';
import 'package:practice_advance/features/home_author/presentation/authors_list.dart';
import 'package:practice_advance/features/onboarding/onboarding_screen.dart';
import 'package:practice_advance/features/sign_in/presentation/sign_in_screen.dart';
import 'package:practice_advance_design/widgets/images/icon.dart';
import 'package:practice_advance_design/widgets/layout/scaffold.dart';
import 'package:practice_advance_design/widgets/navigation/main_navigator.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_package/main.dart';

import 'features/home_vendor/presentation/vendors_list.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellBottomNavLayoutNavigatorKey = GlobalKey<NavigatorState>();

class AppRouteNames {
  static BazarRoute splash = BazarRoute(
    '/splash',
    AgbPageNames.splash,
  );
  static BazarRoute login = BazarRoute(
    '/login',
    AgbPageNames.login,
  );
  static BazarRoute detailAuthor = BazarRoute(
    '/detailAuthor',
    AgbPageNames.detailAuthor,
  );
  static BazarRoute detailVendor = BazarRoute(
    '/detailVendor',
    AgbPageNames.detailVendor,
  );
  static BazarRoute detailProduct = BazarRoute(
    '/detailProduct',
    AgbPageNames.detailProduct,
  );
  static BazarRoute authorList = BazarRoute(
    '/authorList',
    AgbPageNames.authorList,
  );
  static BazarRoute vendorList = BazarRoute(
    '/vendorList',
    AgbPageNames.vendorList,
  );
  static BazarRoute productList = BazarRoute(
    '/productList',
    AgbPageNames.productList,
  );
  static BazarRoute welcome = BazarRoute(
    '/welcome',
    AgbPageNames.welcome,
  );
  static BazarRoute onboarding = BazarRoute(
    '/onboarding',
    AgbPageNames.onboarding,
  );

  // Home route
  static BazarRoute home = BazarRoute('/home', AgbPageNames.home);
  static BazarRoute category = BazarRoute('/category', AgbPageNames.category);
  static BazarRoute cart = BazarRoute('/cart', AgbPageNames.cart);
  static BazarRoute profile = BazarRoute('/profile', AgbPageNames.profile);
}

final GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRouteNames.login.path,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRouteNames.login.path,
      builder: (BuildContext context, GoRouterState state) => LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRouteNames.onboarding.path,
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRouteNames.authorList.path,
      name: AppRouteNames.authorList.name,
      builder: (BuildContext context, GoRouterState state) {
        final param = state.extra != null ? state.extra! as AuthorBloc : null;

        return ListAuthorsScreen(bloc: param!);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRouteNames.vendorList.path,
      name: AppRouteNames.vendorList.name,
      builder: (BuildContext context, GoRouterState state) {
        final param = state.extra != null ? state.extra! as VendorBloc : null;

        return ListVendorsScreen(bloc: param!);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: AppRouteNames.detailAuthor.path,
      name: AppRouteNames.detailAuthor.name,
      builder: (BuildContext context, GoRouterState state) {
        final param = state.extra != null ? state.extra! as Author : null;

        return AuthorDetail(author: param!);
      },
    ),
    ShellRoute(
      navigatorKey: _shellBottomNavLayoutNavigatorKey,
      builder: (context, state, child) => BazarScaffold(
        mainNavigation: BazarMainNavigation(
          items: _navigationItems(context),
        ),
        body: child,
      ),
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
            child: CartScreen(),
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

List<BazarBottomNavBarModel> _navigationItems(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  final intl = AppLocalizations.of(context)!;

  return <BazarBottomNavBarModel>[
    BazarBottomNavBarModel(
      label: intl.txtHome,
      icon: BazarIcon.ichome(),
      activeIcon: BazarIcon.ichome(color: theme.primary),
      routeNamed: AppRouteNames.home,
    ),
    BazarBottomNavBarModel(
      label: intl.txtCategory,
      icon: BazarIcon.icCategory(),
      activeIcon: BazarIcon.icCategory(color: theme.primary),
      routeNamed: AppRouteNames.category,
    ),
    BazarBottomNavBarModel(
      label: intl.txtCart,
      icon: BazarIcon.icCart(),
      activeIcon: BazarIcon.icCart(color: theme.primary),
      routeNamed: AppRouteNames.cart,
    ),
    BazarBottomNavBarModel(
      label: intl.txtProfile,
      icon: BazarIcon.icProfile(),
      activeIcon: BazarIcon.icProfile(color: theme.primary),
      routeNamed: AppRouteNames.profile,
    ),
  ];
}
