import 'package:elbe/elbe.dart';

/// create a decoration for a text field. Use this to style the text field.
/// It automatically uses the theme of the context.
InputDecoration elbeFieldDeco(BuildContext context,
    {String? hint, String? label, InputDecoration? mergeWith}) {
  final t = context.theme;

  border(LayerColor c) => OutlineInputBorder(
      gapPadding: 2,
      borderSide: BorderSide(
          color: c.border ?? Colors.transparent,
          width: t.geometry.border.pixelWidth ?? 0),
      borderRadius: t.geometry.border.radius ?? BorderRadius.circular(0));

  return (mergeWith ?? const InputDecoration()).copyWith(
      labelText: label,
      hintText: hint,
      hintStyle: t.type.bodyM
          .toTextStyle(context)
          .copyWith(color: t.color.selected.front.withAlpha(110)),
      border: border(t.color.selected),
      enabledBorder: border(t.color.selected),
      focusedBorder: border(
          t.color.resolve(kind: ColorKinds.accent, manner: ColorManners.minor)),
      disabledBorder: border(t.color.resolve(state: ColorStates.disabled)),
      errorBorder: border(
          t.color.resolve(kind: ColorKinds.error, manner: ColorManners.major)));
}
