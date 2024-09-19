///
/// Models for dropdown with generic type support.
/// Includes:
///   - title: Text show on dropdown when the item selected
///   - value: value will received dropdown item selected
///
class AgbUiDropdownModel<T> {
  AgbUiDropdownModel({
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

class AgbUiRoute {
  AgbUiRoute(
    this.path,
    this.name,
  );

  final String path;

  final String name;
}
