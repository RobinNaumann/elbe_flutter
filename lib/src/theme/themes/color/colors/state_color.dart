import 'package:elbe/elbe.dart';
import 'package:elbe/src/theme/themes/color/color_seed.dart';

/// some Widgets are interactive and can be in one of these states
/// - `neutral` is the default state
/// - `hovered` is when the user is hovering over the widget
/// - `active` is when the user is pressing the widget
/// - `disabled` is when the widget is not interactive
enum ColorStates { neutral, hovered, active, disabled }

class StateColor extends LayerColor {
  final LayerColor neutral;
  final LayerColor hover;
  final LayerColor active;
  final LayerColor disabled;

  StateColor(
      {required this.neutral,
      required this.hover,
      required this.active,
      required this.disabled})
      : super.from(neutral);

  StateColor.from(StateColor c)
      : this(
            neutral: c.neutral,
            hover: c.hover,
            active: c.active,
            disabled: c.disabled);

  LayerColor? maybeState(ColorStates? state) =>
      state != null ? this.state(state) : null;

  LayerColor state(ColorStates state) =>
      [neutral, hover, active, disabled][state.index];

  factory StateColor.generate(ColorSeed _, LayerColor context, LayerColor style,
      [bool fromFront = false]) {
    _make(double factor) {
      final front = style.front;
      return new LayerColor(
          back: (fromFront
                  ? context.back.inter(front, factor)
                  : style.back.inter(context.back.mirrorBrightness(), factor))
              .withOpacity(Math.max(style.back.alpha / 255, 0.2)),
          front: front,
          border: style.border,
          borderContext: style.borderContext);
    }

    return new StateColor(
        neutral: style,
        hover: _make(0.075),
        active: _make(0.25),
        disabled: style.desaturated());
  }

  StateColor copyWith(
          {LayerColor? neutral,
          LayerColor? hovered,
          LayerColor? pressed,
          LayerColor? disabled}) =>
      StateColor(
          neutral: neutral ?? this.neutral,
          hover: hovered ?? this.hover,
          active: pressed ?? this.active,
          disabled: disabled ?? this.disabled);

  @override
  get map => {
        "neutral": neutral.map,
        "hover": hover.map,
        "active": active.map,
        "disabled": disabled.map
      };
}
