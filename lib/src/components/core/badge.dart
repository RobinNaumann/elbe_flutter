import '../../../elbe.dart';

class Badge extends ThemedWidget {
  final int? value;
  final String? text;
  final AlertType type;
  const Badge({super.key, this.value, this.text, this.type = AlertType.info});

  @override
  Widget make(context, theme) {
    final label =
        text ?? (value != null ? ((value! > 999) ? "999+" : "$value") : null);
    return Box(
        style: type.major,
        constraints: const RemConstraints(minWidth: 1),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        padding: const RemInsets.symmetric(vertical: 0.06, horizontal: 0.25),
        child: Text(label ?? "", style: TypeStyles.bodyS));
  }
}
