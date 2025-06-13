import 'package:elbe/elbe.dart';

/// create a decoration for a text field. Use this to style the text field.
/// It automatically uses the theme of the context.
InputDecoration elbeFieldDeco(BuildContext context,
    {String? hint, String? label, InputDecoration? mergeWith}) {
  final t = ThemeData.fromContext(context);

  border(LayerColor c) => OutlineInputBorder(
      gapPadding: 2,
      borderSide: BorderSide(
          color: c.border ?? Colors.transparent,
          width: t.geometry.border.pixelWidth ?? 0),
      borderRadius: t.geometry.border.borderRadius ?? BorderRadius.circular(0));

  return (mergeWith ?? const InputDecoration()).copyWith(
      labelText: label,
      hintText: hint,
      hintStyle: t.type.bodyM
          .toTextStyle(context)
          .copyWith(color: t.color.activeLayers.front.withAlpha(110)),
      border: border(t.color.activeLayers),
      enabledBorder: border(t.color.activeLayers),
      focusedBorder: border(t.color.activeKinds.accent.safeMinor),
      disabledBorder: border(t.color.activeStates.disabled),
      errorBorder: border(t.color.activeKinds.error));
}
