///
/// Models for dropdown with generic type support.
/// Includes:
///   - title: Text show on dropdown when the item selected
///   - value: value will received dropdown item selected
///
class BazarDropdownModel<T> {
  BazarDropdownModel({
    required this.title,
    required this.value,
    this.subTitle,
    this.trailingText,
  });

  final String title;
  final T value;
  final String? subTitle;
  final String? trailingText;
}

class BazarRoute {
  BazarRoute(
    this.path,
    this.name,
  );

  final String path;

  final String name;
}
