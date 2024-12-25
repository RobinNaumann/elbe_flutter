import 'package:elbe/elbe.dart';

class Spinner extends StatelessWidget {
  /// a circular progress indicator that adapts to the platform.
  /// it is used to indicate that the app is busy.
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
