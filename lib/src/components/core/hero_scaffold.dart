import 'package:flutter/material.dart' as m;

import '../../../elbe.dart';
import '../../thirdparty/invisible_header.dart';

/// A scaffold with a hero sliver at the top. This creates a
/// parallax effect when scrolling.
class HeroScaffold extends ThemedWidget {
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

  Widget _heroBase(Widget child, bool left, bool single) => Card(
      constraints: const RemConstraints(minHeight: 3.1),
      padding: RemInsets.symmetric(
          vertical: 0.3, horizontal: (single || left) ? 0.3 : 0.6),
      border: Border(borderRadius: BorderRadius.circular(200), pixelWidth: 0),
      margin: RemInsets(left: left ? 0.4 : 0, right: left ? 0 : 0.4),
      child: child);

  @override
  Widget make(context, theme) {
    final prim = theme.color.activeScheme;

    return m.Scaffold(
        backgroundColor: prim.plain.neutral.back,
        body: CustomScrollView(slivers: [
          SliverAppBar(
              leading: leadingIcon?.icon != null
                  ? Center(
                      child: _heroBase(
                          IconButton.flatPlain(
                              onTap: leadingIcon!.onTap != null
                                  ? () => leadingIcon!.onTap?.call(context)
                                  : null,
                              icon: leadingIcon!.icon!),
                          true,
                          false),
                    )
                  : null,
              actions: (actions != null && actions!.isNotEmpty)
                  ? [
                      _heroBase(Row(children: actions!.spaced(amount: 0.4)),
                          false, actions?.length == 1)
                    ]
                  : null,
              pinned: true,
              collapsedHeight: 83,
              backgroundColor: prim.plain.neutral.back,
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
                      color: prim.accent.inter(prim.plain.neutral, 0.9).back,
                      //padding: RemInsets(bottom: 2),
                      margin: EdgeInsets.only(bottom: 2),
                      child: FlexibleSpaceBar(
                          background: Box(
                              scheme: ColorSchemes.secondary, child: hero))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      clipBehavior: Clip.none,
                      height: 19,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(17)),
                          color: theme.color.activeLayer.back),
                    ),
                  )
                ],
              )),
          if (body != null) SliverToBoxAdapter(child: body),
          if (bodyList != null) ...bodyList!
        ]));
  }
}
