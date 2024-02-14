import 'package:flutter/material.dart' as m;
import 'package:flutter/cupertino.dart' as c;
import 'package:lucide_icons/lucide_icons.dart' as l;

// EXPORTS

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

//themes

export 'src/theme/themes/geometry/geometry_theme_data.dart';
export 'src/theme/themes/geometry/geometry_theme.dart';

export 'src/theme/themes/type/type_style.dart';
export 'src/theme/themes/type/type_theme_data.dart';
export 'src/theme/themes/type/type_theme.dart';
export 'src/theme/util/theme.dart';

export 'src/theme/themes/color/color_style.dart';
export 'src/theme/themes/color/color_theme_data.dart';
export 'src/theme/themes/color/color_theme.dart';

export 'src/theme/themes/color/alert_type.dart';

//utils

export 'src/theme/util/definitions.dart';
export 'src/theme/util/rem_insets.dart';
export 'src/theme/util/rem_constraints.dart';

// components

export 'src/components/core/elbe_app.dart';
export 'src/components/core/badge.dart';
export 'src/components/core/toggle_buttons.dart';
export 'src/components/core/toggle_button.dart';
export 'src/components/core/padded.dart';
export 'src/components/core/box.dart';
export 'src/components/core/card.dart';
export 'src/components/core/icon.dart';
export 'src/components/core/text.dart';
export 'src/components/core/button.dart';
export 'src/components/core/title.dart';
export 'src/components/core/scaffold.dart';
export 'src/components/core/hero_scaffold.dart';
export 'src/components/core/center_message.dart';

export 'src/components/util/spaced.dart';
export 'src/components/util/elbe_stateless_widget.dart';
export 'src/components/util/spaced_list.dart';

export 'package:collection/collection.dart';
export 'package:package_info_plus/package_info_plus.dart';

export 'services/s_app_info.dart';
export 'services/s_logger.dart';

export 'util/lorem.dart';
export 'util/math.dart';

// bit state management
export 'bit/bit.dart';

typedef MaterialIcons = m.Icons;
typedef ApfelIcons = c.CupertinoIcons;
typedef Icons = l.LucideIcons;

/// A shorthand for using the regular [Text] widget instead of the one provided by Elbe.
typedef WText = m.Text;

/// A shorthand for using the regular [Icon] widget instead of the one provided by Elbe.
typedef WIcon = m.Icon;

typedef WBorder = m.Border;
