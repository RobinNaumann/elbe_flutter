import 'package:elbe/elbe.dart';

class ElbeRoute {
  final String path;
  final Widget Function(BuildContext) builder;

  const ElbeRoute({required this.path, required this.builder});
}

class MenuRoute extends ElbeRoute {
  final IconData icon;
  final String label;
  final bool bottom;
  final bool disabled;

  const MenuRoute({
    required String path,
    required this.label,
    required Widget Function(BuildContext) builder,
    required this.icon,
    this.bottom = false,
    this.disabled = false,
  }) : super(path: path, builder: builder);
}
