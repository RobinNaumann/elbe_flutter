import 'package:flutter/material.dart' as m;

import '../../../elbe.dart';
import '../../thirdparty/invisible_header.dart';

class _HeroBase extends StatelessWidget {
  final Widget child;
  final bool left;
  final bool single;

  const _HeroBase(
      {required this.child, this.left = false, this.single = false});

  @override
  build(BuildContext context) => Card(
      constraints: const RemConstraints(minHeight: 3.1),
      padding: RemInsets.symmetric(
          vertical: 0.3, horizontal: (single || left) ? 0.3 : 0.6),
      radius: 12,
      border: Border(width: 0),
      margin: RemInsets(left: left ? 0.4 : 0, right: left ? 0 : 0.4),
      child: child);
}

/// A scaffold with a hero sliver at the top. This creates a
/// parallax effect when scrolling.
class HeroScaffold extends StatelessWidget {
  final String title;
  final Widget hero;
  final List<Widget>? actions;
  final LeadingIcon? leadingIcon;
  final rem heroHeight;
  final Widget? customTitle;
  final bool centerTitle;
  final Widget? body;
  final List<Widget>? bodyList;

  /// Page foundation with a hero sliver at the top.
  /// The [hero] is the widget that will be displayed at the top.
  /// Scrolling will trigger a parallax effect.
  ///
  /// use `Scaffold` for a normal page.
  const HeroScaffold(
      {super.key,
      required this.hero,
      required this.title,
      this.actions,
      this.leadingIcon,
      this.heroHeight = 18,
      this.body,
      this.bodyList,
      this.customTitle,
      this.centerTitle = true})
      : assert((body != null) ^ (bodyList != null),
            "Provide exactly one of body or bodyList");

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final prim = theme.color.selected;

    return m.Scaffold(
        backgroundColor: prim.back,
        body: CustomScrollView(slivers: [
          SliverAppBar(
              leading: leadingIcon?.icon != null
                  ? Center(
                      child: _HeroBase(
                        left: true,
                        child: IconButton.plain(
                            onTap: leadingIcon!.onTap != null
                                ? () => leadingIcon!.onTap?.call(context)
                                : null,
                            icon: leadingIcon!.icon!),
                      ),
                    )
                  : null,
              actions: (actions != null && actions!.isNotEmpty)
                  ? [
                      _HeroBase(
                          left: false,
                          single: actions?.length == 1,
                          child: Row(gap: .4, children: actions!))
                    ]
                  : null,
              pinned: true,
              collapsedHeight: context.rem(3.5),
              backgroundColor: prim.back,
              automaticallyImplyLeading: false,
              title: customTitle ??
                  InvisibleExpandedHeader(
                    child: Text.h4(title, textAlign: TextAlign.center),
                  ),
              expandedHeight: context.rem(heroHeight),
              centerTitle: centerTitle,
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      color: prim.back,
                      padding: context.app.layoutMode.isWide
                          ? EdgeInsets.symmetric(horizontal: context.rem(.5))
                          : null,
                      child: FlexibleSpaceBar(
                          background: Box(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(context
                                      .rem(theme.geometry.borderRadius))),
                              scheme: ColorSchemes.secondary,
                              child: hero))),
                  InvisibleExpandedHeader(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      clipBehavior: Clip.none,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ColorDefs.black.withAlpha(60),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                      ),
                    ),
                  ))
                ],
              )),
          if (body != null) SliverToBoxAdapter(child: body),
          if (bodyList != null) ...bodyList!
        ]));
  }
}
