import 'dart:math';

import 'package:flutter/material.dart' as m;

import '../../../elbe.dart';
import 'maybe_hero.dart';

_popPage(BuildContext context) {
  final r = GoRouter.maybeOf(context);
  if (r == null) return m.Navigator.maybeOf(context)?.maybePop();
  if (r.canPop()) r.pop();
}

class LeadingIcon {
  static _noFn(c) {}

  final IconData? icon;
  final Function(BuildContext context)? onTap;

  const LeadingIcon.none()
      : icon = null,
        onTap = _noFn;
  const LeadingIcon.back()
      : icon = Icons.chevronLeft,
        onTap = _popPage;
  const LeadingIcon.close()
      : icon = Icons.x,
        onTap = _popPage;
  const LeadingIcon({required this.icon, this.onTap});
}

/// base widget for creating screen filling pages
class Scaffold extends ThemedWidget {
  final ColorSchemes? scheme;
  final String title;
  final List<Widget>? actions;
  final LeadingIcon? leadingIcon;
  final bool resizeOnKeyboard;
  final String? heroTag;
  final Widget? customTitle;
  final Widget? child;
  final List<Widget>? children;

  /// create a scaffold with a single child or a list of children
  ///
  /// for a parallax effect, you can use `HeroScaffold`
  const Scaffold(
      {super.key,
      this.scheme = ColorSchemes.primary,
      required this.title,
      this.customTitle,
      this.actions,
      this.leadingIcon,
      this.resizeOnKeyboard = true,
      this.heroTag,
      this.child,
      this.children})
      : assert(child == null || children == null,
            "provide only one of child, children");

  @override
  Widget make(context, theme) {
    bool implyLeading = GoRouter.maybeOf(context)?.canPop() ?? false;
    var leading = leadingIcon;
    if (implyLeading && leading == null) {
      leading = const LeadingIcon.back();
    }
    final s = theme.color.activeScheme.scheme(scheme ?? ColorSchemes.primary);

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            AnimatedBuilder(
                animation: animation,
                builder: (_, __) =>
                    animation.status == AnimationStatus.completed
                        ? child
                        : (animation.status == AnimationStatus.reverse
                            ? Box(
                                border: Border.none,
                                mode: theme.color.mode == ColorModes.light
                                    ? ColorModes.dark
                                    : ColorModes.light,
                                child: child)
                            : ClipOval(
                                key: ValueKey(animation.value),
                                clipper: CircleClip(animation.value),
                                child: child))),
        child: m.Scaffold(
          key: ValueKey(theme.color.mode),
          resizeToAvoidBottomInset: resizeOnKeyboard,
          backgroundColor: s.plain.neutral,
          appBar: AppBar(
            //toolbarHeight: 50,
            elevation: 0,
            scrolledUnderElevation: 3,
            surfaceTintColor: theme.color.activeScheme.accent,
            backgroundColor: theme.color.activeLayer.back,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: leading != null
                ? leading.icon != null
                    ? Padded.all(
                        value: .5,
                        child: IconButton.flatPlain(
                            onTap: leading.onTap != null
                                ? () => leading!.onTap?.call(context)
                                : null,
                            icon: leading.icon!))
                    : null
                : null,
            actions: actions?.isEmpty ?? true
                ? null
                : [
                    Padded.only(
                        right: 0.4,
                        child: Row(children: actions!.spaced(amount: 0.4)))
                  ],
            title: customTitle ?? Text.h4(title),
          ),
          body: MaybeHero(
              tag: heroTag,
              child: child ??
                  ListView(
                      padding: const RemInsets.all(1).toPixel(context),
                      children: children ?? [])),
        ));
  }
}

class CircleClip extends CustomClipper<Rect> {
  final double value;
  CircleClip(this.value);

  @override
  Rect getClip(Size size) {
    final m = max(size.width, size.height);
    return Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: (m * 1.3) * value,
        height: (m * 1.3) * value);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

extension Toast on BuildContext {
  /// show a toast message at the bottom of the screen
  /// the message will be displayed for 2 seconds
  void showToast(String message,
      {IconData? icon,
      ColorKinds? kind,
      ColorManners? manner,
      Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: theme.color.activeScheme.inverse,
      padding: m.EdgeInsets.all(0),
      content: Card(
        scheme: ColorSchemes.inverse,
        padding: RemInsets.all(1),
        border: Border.noneRect,
        kind: kind,
        manner: manner,
        child: Row(
            children: [
          if (icon != null) Icon(icon),
          Expanded(
            child: Text(message),
          )
        ].spaced(amount: 0.75)),
      ),
    ));
  }
}
