import '../../../elbe.dart';

/// A badge to display a value or text in a small container.
/// The badge can have a color scheme to indicate its importance.
/// The badge can have a value or text.
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
        kind: type.kind,
        manner: ColorManners.major,
        constraints: const RemConstraints(minWidth: 1),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        padding: RemInsets.symmetric(
            vertical: 0.06,
            horizontal: value != null || (text ?? "").length > 0 ? .35 : .6),
        child: Text(label ?? "", style: TypeStyles.bodyS));
  }
}
