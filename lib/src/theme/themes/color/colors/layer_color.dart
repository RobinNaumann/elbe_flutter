import 'package:elbe/src/theme/themes/color/colors/rich_color.dart';
import 'package:flutter/material.dart';

/// these are the different layers of a color
enum ColorLayers { back, front, border }

abstract class _JsonColor {
  Map<String, dynamic> get map;

  _JsonColor.from(Color c); //: super(c.value);

  @override
  String toString() => "$runtimeType$map";

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}

/// a color with three layers: back, front, and border
///
/// the [back] layer is the main color of the element
/// the [front] layer is the color of the text and icons
/// the [border] layer is the color of the border. If null,
/// the border is transparent
class LayerColor extends _JsonColor {
  /// the background color. This is the main color of the element
  final Color back;

  /// the front color. This is the color of the text and icons
  final Color front;

  /// the border color. This is the color of the border. If null, the border is transparent
  final Color? border;
  final Color? borderContext;

  LayerColor.from(LayerColor c)
      : this(back: c.back, front: c.front, border: c.border);

  /// a layer color is a color with three layers: back, front, and border
  /// the back layer is the main color of the element
  /// the front layer is the color of the text and icons
  /// the border layer is the color of the border
  LayerColor(
      {required this.back,
      required this.front,
      this.border,
      this.borderContext})
      : super.from(back);

  factory LayerColor.fromBack(Color back, {Color? front, Color? border}) {
    front ??= back.isDark ? Colors.white : Colors.black;
    return LayerColor(back: back, front: front, border: border);
  }

  Color layer(ColorLayers layer) =>
      [back, front, border ?? Colors.transparent][layer.index];

  Color? maybeLayer(ColorLayers? layer) =>
      layer != null ? this.layer(layer) : null;

  /// mirror the brightness of a color. keep the hue and saturation
  /// [factor] = 1 will return the inverted color, 0 will return the same color
  LayerColor mirrorBrightness([double factor = 1]) => LayerColor(
      back: back.mirrorBrightness(factor),
      front: front.mirrorBrightness(factor),
      border: border?.mirrorBrightness(factor),
      borderContext: borderContext?.mirrorBrightness(factor));

  /// interpolate between two colors
  /// [factor] = 1 will return the other color, 0 will return the same color
  LayerColor inter(LayerColor other, double factor) => LayerColor(
      back: this.back.inter(other.back, factor),
      front: this.front.inter(other.front, factor),
      border: this.border?.inter(other.border ?? Colors.transparent, factor),
      borderContext: this
          .borderContext
          ?.inter(other.borderContext ?? Colors.transparent, factor));

  /// return a color with the same hue but different saturation
  /// [factor] = 1 will return the same color, 0 will return grey
  LayerColor desaturated([double factor = 1]) => LayerColor(
      back: back.desaturated(factor),
      front: front.desaturated(factor),
      border: border?.desaturated(factor),
      borderContext: borderContext?.desaturated(factor));

  @override
  get map => {
        "back": back.map,
        "front": front.map,
        "border": border?.map,
        "borderContext": borderContext?.map
      };
}
