import '../../../elbe.dart';

/// a helper class for creating stateless widgets that depend on the theme.
abstract class ThemedWidget extends StatelessWidget {
  const ThemedWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      make(context, ThemeData.fromContext(context));

  Widget make(BuildContext context, ThemeData theme);
}
