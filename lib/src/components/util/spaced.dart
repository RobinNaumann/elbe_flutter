// ignore_for_file: use_key_in_widget_constructors

import '../../../elbe.dart';

/// a visual spacer that can be placed between objects to ensure consistent margins
class Spaced extends ThemedWidget {
  static const zero = Spaced(height: 0, width: 0);

  final double width;
  final double height;

  const Spaced({super.key, this.width = 1, this.height = 1});
  const Spaced.vertical([this.height = 1]) : width = 0;
  const Spaced.horizontal([this.width = 1]) : height = 0;

  @override
  Widget make(context, theme) =>
      SizedBox(width: theme.rem(width), height: theme.rem(height));
}
