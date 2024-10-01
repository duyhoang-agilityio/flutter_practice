import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/foundations/models.dart';

/// Main bottom navigation
///
/// Main bottom navigation
///
/// This widget displays a bottom navigation bar with
/// the given items.
///
/// When the user taps on an item, this widget will navigate to the
/// item's [BazarBottomNavBarModel.routeNamed] route.
class BazarMainNavigation extends StatelessWidget {
  /// Creates a main navigation widget
  ///
  /// The [items] parameter must not be null.
  const BazarMainNavigation({
    required this.items,
    super.key,
  });

  /// The items to be displayed on the bottom navigation bar
  final List<BazarBottomNavBarModel> items;

  @override
  Widget build(BuildContext context) {
    // Get the current location
    final route = GoRouter.of(context);
    final location = route.routerDelegate.currentConfiguration.fullPath;

    // Create a bottom navigation bar with the items
    return Theme(
      // Copy the theme and remove the splash and highlight colors
      data: context.theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: context.colorScheme.surface,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        items: items
            .map(
              // Add some padding to the icons
              (itm) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: itm.icon,
                ),
                label: itm.label,
                // Add some padding to the active icon
                activeIcon: Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: itm.activeIcon,
                ),
              ),
            )
            .toList(),
        // Get the current item's index
        currentIndex: max(
          items
              .map((item) => context.namedLocation(item.routeNamed!.name))
              .toList()
              .indexWhere(location.startsWith),
          0,
        ),
        onTap: (int index) {
          // Get the destination route
          final destinationRoute = items[index].routeNamed!.name;
          final destination = context.namedLocation(destinationRoute);

          // If the destination is the same as the current
          // location, do nothing
          if (destination ==
              GoRouter.of(context)
                  .routerDelegate
                  .currentConfiguration
                  .fullPath) {
            return;
          }

          // Navigate to the destination
          return context.go(destination);
        },
        // Remove the elevation
        elevation: 0,
      ),
    );
  }
}

/// A model for the [BazarMainNavigation]
///
/// This model holds the data needed to create a bottom navigation bar item.
/// The model holds the [label], [icon] and [activeIcon] that will be used
/// to create the bottom navigation bar item, and the [routeNamed] that
/// represents the route that this item will navigate to.
class BazarBottomNavBarModel {
  /// Creates a [BazarBottomNavBarModel]
  ///
  /// The [label] and [icon] are required, and the [activeIcon] defaults to
  /// the [icon]. The [routeNamed] is optional.
  BazarBottomNavBarModel({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.routeNamed,
  });

  /// The label for the bottom navigation bar item
  final String label;

  /// The icon for the bottom navigation bar item
  final Widget icon;

  /// The active icon for the bottom navigation bar item
  ///
  /// Defaults to the [icon] if not provided.
  final Widget activeIcon;

  /// The route that this item will navigate to
  final BazarRoute? routeNamed;
}
