import 'package:elbe/src/theme/themes/color/color_seed.dart';
import 'package:elbe/src/theme/themes/color/colors/layer_color.dart';

import 'manner_color.dart';

/// these are the different main types of colors that can be used in the app
enum ColorKinds { plain, accent, info, success, warning, error }

class KindColor extends MannerColor {
  final MannerColor plain;
  final MannerColor accent;
  final MannerColor info;
  final MannerColor success;
  final MannerColor warning;
  final MannerColor error;

  KindColor(
      {required this.plain,
      required this.accent,
      required this.info,
      required this.success,
      required this.warning,
      required this.error})
      : super.from(plain);

  KindColor.from(KindColor c)
      : this(
            plain: c.plain,
            accent: c.accent,
            info: c.info,
            success: c.success,
            warning: c.warning,
            error: c.error);

  MannerColor kind(ColorKinds kind) =>
      [plain, accent, info, success, warning, error][kind.index];

  MannerColor? maybeKind(ColorKinds? kind) =>
      kind != null ? this.kind(kind) : null;

  factory KindColor.generate(ColorSeed s, LayerColor c) => KindColor(
      plain: MannerColor.generate(s, c),
      accent: MannerColor.generate(s, c, s.style.accent(s, c, s.accent)),
      info: MannerColor.generate(s, c, s.style.info(s, c, s.info)),
      success: MannerColor.generate(s, c, s.style.success(s, c, s.success)),
      warning: MannerColor.generate(s, c, s.style.warning(s, c, s.warning)),
      error: MannerColor.generate(s, c, s.style.error(s, c, s.error)));

  @override
  get map => {
        "plain": plain.map,
        "accent": accent.map,
        "info": info.map,
        "success": success.map,
        "warning": warning.map,
        "error": error.map
      };
}
