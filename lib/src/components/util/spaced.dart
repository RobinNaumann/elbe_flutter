// ignore_for_file: use_key_in_widget_constructors

import '../../../elbe.dart';

/// a type for spacing information
// ignore: camel_case_types
typedef rem = double;

extension ExpandedWidget on Widget {
  /// wraps the widget in an Expanded
  Expanded get expanded => Expanded(child: this);

  /// wraps the widget in a Flexible
  Flexible get flexible => Flexible(child: this);

  /// wraps the widget in a IntrinsicHeight
  IntrinsicHeight get fitHeight => IntrinsicHeight(child: this);

  /// wraps the widget in a IntrinsicWidth
  IntrinsicWidth get fitWidth => IntrinsicWidth(child: this);
}

/// a visual spacer that can be placed between objects to ensure consistent margins
class Spaced extends ThemedWidget {
  static const zero = Spaced(height: 0, width: 0);

  final double width;
  final double height;

  /// widget for adding whitespace btween objects
  ///
  /// also take a look at `Padded` for adding padding around objects.
  ///
  /// you can also [].spaced() a list of widgets to add spacing between them.
  const Spaced({super.key, this.width = 1, this.height = 1});
  const Spaced.vertical([this.height = 1]) : width = 0;
  const Spaced.horizontal([this.width = 1]) : height = 0;

  @override
  Widget make(context, theme) =>
      SizedBox(width: theme.rem(width), height: theme.rem(height));
}
