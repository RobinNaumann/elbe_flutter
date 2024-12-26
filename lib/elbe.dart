import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart' as m;
import 'package:lucide_icons/lucide_icons.dart' as l;

export 'package:collection/collection.dart';
export 'package:flutter/material.dart'
    hide
        Icon,
        Text,
        Icons,
        ColorScheme,
        Badge,
        ThemeData,
        Theme,
        Card,
        Border,
        Scaffold,
        IconButton,
        ToggleButtons,
        Title;
// EXPORTS

export 'package:go_router/go_router.dart';
export 'package:package_info_plus/package_info_plus.dart';

// bit state management
export 'bit/bit.dart';
export 'services/s_app_info.dart';
export 'services/s_logger.dart';
export 'src/components/core/badge.dart';
export 'src/components/core/box.dart';
export 'src/components/core/button.dart';
export 'src/components/core/card.dart';
export 'src/components/core/center_message.dart';
export 'src/components/core/drop_down.dart';
// components

export 'src/components/core/elbe_app.dart';
export 'src/components/core/hero_scaffold.dart';
export 'src/components/core/icon.dart';
export 'src/components/core/options_button.dart';
export 'src/components/core/padded.dart';
export 'src/components/core/scaffold.dart';
export 'src/components/core/slider.dart';
export 'src/components/core/spinner.dart';
export 'src/components/core/text.dart';
export 'src/components/core/title.dart';
export 'src/components/core/toggle_button.dart';
export 'src/components/field/field_deco.dart';
export 'src/components/util/elbe_stateless_widget.dart';
export 'src/components/util/spaced.dart';
export 'src/components/util/spaced_list.dart';
// errors
export 'src/errors/elbe_error.dart';
export 'src/errors/elbe_errors.dart';
export 'src/errors/p_elbe_error.dart';
export 'src/errors/v_elbe_error.dart';
export 'src/theme/themes/color/alert_type.dart';
export 'src/theme/themes/color/color_theme.dart';
export 'src/theme/themes/color/color_theme_data.dart';
export 'src/theme/themes/geometry/geometry_theme.dart';
//themes
export 'src/theme/themes/geometry/geometry_theme_data.dart';
export 'src/theme/themes/type/type_style.dart';
export 'src/theme/themes/type/type_theme.dart';
export 'src/theme/themes/type/type_theme_data.dart';
export 'src/theme/util/definitions.dart';
export 'src/theme/util/rem_constraints.dart';
export 'src/theme/util/rem_insets.dart';
export 'src/theme/util/theme.dart';
export 'src/util/opt.dart';
//utils
export 'src/util/unix_date.dart';
export 'util/aliases.dart';
export 'util/lorem.dart';
export 'util/m_data.dart';
export 'util/math.dart';
export 'util/try.dart';

typedef MaterialIcons = m.Icons;
typedef ApfelIcons = c.CupertinoIcons;
typedef Icons = l.LucideIcons;
