import 'package:elbe/elbe.dart';
import 'package:flutter/material.dart' as m;

/// select a value from a linear scale
class SliderSelect extends StatelessWidget {
  final double value;
  final Function(double value)? onChanged;
  final double min;
  final double max;

  /// create a slider to select a value from a linear scale
  ///
  /// [value] is the current value of the slider
  ///
  /// [onChanged] is called when the value of the slider changes
  ///
  /// [min] is the minimum value of the slider
  ///
  /// [max] is the maximum value of the slider
  const SliderSelect(
      {super.key,
      required this.value,
      required this.onChanged,
      this.min = 0,
      this.max = 10});

  @override
  Widget build(BuildContext context) {
    return m.Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        onChanged: onChanged != null ? (v) => onChanged!(v) : null,
        activeColor: ThemeData.fromContext(context)
            .color
            .activeKinds
            .accent
            .safeMajor
            .back,
        inactiveColor:
            ThemeData.fromContext(context).color.activeLayers.border);
  }
}
