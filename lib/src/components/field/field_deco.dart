import 'package:elbe/elbe.dart';

/// create a decoration for a text field. Use this to style the text field.
/// It automatically uses the theme of the context.
InputDecoration elbeFieldDeco(BuildContext context, {String? hint}) {
  final t = ThemeData.fromContext(context);

  border(LayerColor c) => OutlineInputBorder(
      gapPadding: 2,
      borderSide: BorderSide(
          color: c.border ?? Colors.transparent,
          width: t.geometry.border.pixelWidth ?? 0),
      borderRadius: t.geometry.border.borderRadius ?? BorderRadius.circular(0));

  return InputDecoration(
      hintText: hint,
      hintStyle: t.type.bodyM
          .toTextStyle(context)
          .copyWith(color: t.color.activeLayer.front.withAlpha(110)),
      border: border(t.color.activeLayer),
      enabledBorder: border(t.color.activeLayer),
      focusedBorder: border(t.color.activeKind.accent.safeMinor),
      disabledBorder: border(t.color.activeState.disabled),
      errorBorder: border(t.color.activeKind.error));
}
