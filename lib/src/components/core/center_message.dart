import '../../../elbe.dart';

class CenterMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  const CenterMessage({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              Container(
                  constraints:
                      const RemConstraints(maxWidth: 12).toPixel(context),
                  child: Text(message, textAlign: TextAlign.center))
            ].spaced()));
  }
}
